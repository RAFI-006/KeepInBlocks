using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KeepInBlocksApi.Responses
{
    public class GenericResponse<T>
    {
        public string Messege { get; set; }
        public T Result { get; set; }
        public bool HasError { get; set; }
        public int StatusCode { get; set; }

    }
}
