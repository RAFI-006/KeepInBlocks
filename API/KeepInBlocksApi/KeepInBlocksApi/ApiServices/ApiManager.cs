using KeepInBlocksApi.BusinessModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KeepInBlocksApi.ApiServices
{
    public class ApiManager
    {
        IRestServices restService;
        public ApiManager(IRestServices service)
        {
            restService = service;
        }

        #region /get Transaction
        public Task<TransactionGenericResponse<List<TransactionModel>>> GetTransaction(string address)
        {
            return restService.GetTransaction(address);
        }
        #endregion

        #region /get WalletBaleance
        public Task<TransactionGenericResponse<string>> GetWalletBalance(string address)
        {
            return restService.GetWalletBalance(address);
        }
        #endregion
    }

}

