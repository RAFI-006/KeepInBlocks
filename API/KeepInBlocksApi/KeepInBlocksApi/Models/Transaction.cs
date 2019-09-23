using System;
using System.Collections.Generic;

namespace KeepInBlocksApi.Models
{
    public partial class Transaction
    {
        public int Id { get; set; }
        public string TransactionHash { get; set; }
        public int CredentialsId { get; set; }

        public Credentials Credentials { get; set; }
    }
}
