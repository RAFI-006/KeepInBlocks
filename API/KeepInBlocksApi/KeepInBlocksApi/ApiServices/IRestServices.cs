using KeepInBlocksApi.BusinessModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KeepInBlocksApi.ApiServices
{
    public interface IRestServices
    {
        Task<TransactionGenericResponse<string>> GetWalletBalance(string address);
        // get documents By Sector Id
        Task<TransactionGenericResponse<List<TransactionModel>>>GetTransaction(string address);
    }
}
