using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace KeepInBlocksApi.ApiServices
{
    public class HttpUtils
    {

        #region Generic gun for http get call
        public async static Task<T> GetMyRequest<T>(Uri uri)
        {
            var client = new HttpClient();

            var request = new HttpRequestMessage(HttpMethod.Get, uri);
            var response = client.SendAsync(request).Result;
            if (response.IsSuccessStatusCode)
            {
                string result = response.Content.ReadAsStringAsync().Result;
                return JsonConvert.DeserializeObject<T>(result);
            }
            else
            {
                return default(T);
            }
        }
        #endregion
    }
}
