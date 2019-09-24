using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KeepInBlocksApi.BusinessModel
{
    public class TransactionGenericResponse<T>
    {
        public string status { get; set; }
        public string message { get; set; }
        public T result { get; set; }
    }
}
