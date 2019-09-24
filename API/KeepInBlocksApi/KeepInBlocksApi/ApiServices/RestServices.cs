using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using KeepInBlocksApi.BusinessModel;

namespace KeepInBlocksApi.ApiServices
{
    public class RestServices : IRestServices
    {
        #region Get Wallet Transaction
        public async Task<TransactionGenericResponse<List<TransactionModel>>> GetTransaction(string address)
        {
            var uri = new Uri(string.Format(ApiPath.GetTransaction(address), string.Empty));
            TransactionGenericResponse<List<TransactionModel>> rootObjectModel = await HttpUtils.GetMyRequest<TransactionGenericResponse<List<TransactionModel>>>(uri);

            return rootObjectModel;
        }
        #endregion

        #region Get Wallet Balance
        public async Task<TransactionGenericResponse<string>> GetWalletBalance(string address)
        {
            var uri = new Uri(string.Format(ApiPath.GetWalletBalance(address), string.Empty));
            TransactionGenericResponse<string> rootObjectModel = await HttpUtils.GetMyRequest<TransactionGenericResponse<string>>(uri);

            return rootObjectModel;
        }
        #endregion
    }
}
