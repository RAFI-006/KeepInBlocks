using KeepInBlocksApi.ApiServices;
using KeepInBlocksApi.BlockChainServices.Cryptography;
using KeepInBlocksApi.BusinessModel;
using KeepInBlocksApi.Models;
using Nethereum.Hex.HexConvertors.Extensions;
using Nethereum.Hex.HexTypes;
using Nethereum.RPC.Eth.DTOs;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using Nethereum.Web3.Accounts.Managed;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace KeepInBlocksApi.BlockChainServices
{
    public class BlockChainController
    {
        Web3 web3Instance;
        Account GethAccount;
        ApiManager manager;
        public BlockChainController(Web3 web3,Account account)
        {
            web3Instance = web3;
            GethAccount = account;
            manager = new ApiManager(new RestServices());
        }

        public BlockChainController()
        {

        }

      #region Set Contract data by passing contract Address and Data Model
      public  async Task<Tuple<TransactionReceipt,string>> SetContractData( DataModel model, string key)
        {


            var account = GethAccount;
            var web3 = web3Instance;
            


            var contract = web3.Eth.GetContract(ContractCredentials.abi,ContractCredentials.ContractAdress);

            var setData = contract.GetFunction("setData");
            var serialisedData = Newtonsoft.Json.JsonConvert.SerializeObject(model);
            var encryptedData = CustomEncoding.EnryptString(serialisedData);
            var hash = await setData.SendTransactionAsync(account.Address, new HexBigInteger("100000"), null, key, encryptedData);
            var receipt = await web3.Eth.Transactions.GetTransactionReceipt.SendRequestAsync(hash);

            while (receipt == null)
            {

                receipt = await web3.Eth.Transactions.GetTransactionReceipt.SendRequestAsync(hash);

            }


            return Tuple.Create(receipt, hash);

        }

        #endregion


      #region  get contract data by contract address
     public  async Task<List<DataModel>> GetContractData( string key)
        {




            List<DataModel> getDataListfromBlocks = new List<DataModel>();
            var account = GethAccount;
            var web3 = web3Instance;
            var contract = web3.Eth.GetContract(ContractCredentials.abi, ContractCredentials.ContractAdress);
            int pos = 0;
            string value = "default";
            var getData = contract.GetFunction("getData");
            do
            {
                value = await getData.CallAsync<string>(key, pos);
                if (value != null)
                {
                    var decyptedData = CustomEncoding.DecryptString(value);

                    var userdatamodel = Newtonsoft.Json.JsonConvert.DeserializeObject<DataModel>(decyptedData);


                    getDataListfromBlocks.Add(userdatamodel);


                }

                pos++;
            } while (value != null);



            return getDataListfromBlocks;

        }
        #endregion

      #region Get Wallet Balance
        public async Task<string>GetWalletBalance(string address)
        {

            var response =  await manager.GetWalletBalance(address);
            if (response.status.Equals("1"))
            {
               

                return response.result;
            }
            else
                return "Error";

        }
        #endregion

      #region Get Wallet Transaction
        public async Task<List<TransactionModel>> GetTransaction(string address)
        {

            var response = await manager.GetTransaction(address);
            if (response.status.Equals("1"))
            
                return response.result;

            return response.result;
        }
        #endregion


      #region  deploy contract and get contract Add to store in database
        public async Task<string> DeployContract()
        {



            var account = GethAccount;
            var web3 = web3Instance;
            var transhash = await web3.Eth.DeployContract.SendRequestAsync(ContractCredentials.abi, ContractCredentials.bytecode, account.Address,
                new HexBigInteger("190000"));
            var receipt = await web3.Eth.Transactions.GetTransactionReceipt.SendRequestAsync(transhash);


            while (receipt == null)
            {
                receipt = await web3.Eth.Transactions.GetTransactionReceipt.SendRequestAsync(transhash);

            }

            var defaultGas = web3.TransactionManager.DefaultGas = Nethereum.Signer.Transaction.DEFAULT_GAS_LIMIT;
            var defaultGasPrice = web3.TransactionManager.DefaultGasPrice = Nethereum.Signer.Transaction.DEFAULT_GAS_PRICE;
            var contarctAdd = receipt.ContractAddress;


            return contarctAdd;
        }

        #endregion


      #region Create New Wallet
        public async Task<Account> CreateWallet(string uniquekey)
        {
            var ecKey = Nethereum.Signer.EthECKey.GenerateKey();
            var privateKey = ecKey.GetPrivateKeyAsBytes().ToHex();
            var account = new Nethereum.Web3.Accounts.Account(privateKey);
            return account;
        }
        #endregion
    }

}
