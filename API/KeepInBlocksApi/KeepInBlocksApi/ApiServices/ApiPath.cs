using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KeepInBlocksApi.ApiServices
{
    public class ApiPath
    {
        private readonly static string ApiKey = "PNF6FFJTZH2ZZJG5AGIH9ABQ7YUGMMNW2M";
        public static string BASEURL = "https://api-ropsten.etherscan.io/api?";
        
        public static string GetWalletBalance(string address)
        {
            return BASEURL+ "module=account&action=balance&address="+address+"&tag=latest&apikey=" + ApiKey + "";
        }

        public static string GetTransaction(string address)
        {
            return BASEURL+ "module=account&action=txlist&address=" + address + "&startblock=0&endblock=99999999&sort=asc&apikey=" + ApiKey + "";
        }
    }
}
