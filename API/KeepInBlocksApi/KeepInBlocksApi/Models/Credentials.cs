using System;
using System.Collections.Generic;

namespace KeepInBlocksApi.Models
{
    public partial class Credentials
    {
        public Credentials()
        {
            Transaction = new HashSet<Transaction>();
        }

        public int Id { get; set; }
        public string PrimaryKey { get; set; }
        public string UniqueKey { get; set; }

        public ICollection<Transaction> Transaction { get; set; }
    }
}
