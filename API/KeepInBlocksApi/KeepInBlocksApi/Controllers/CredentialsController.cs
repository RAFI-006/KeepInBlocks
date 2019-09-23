using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using KeepInBlocksApi.Models;
using KeepInBlocksApi.Responses;
using KeepInBlocksApi.BusinessModel;
using Nethereum.Web3.Accounts;
using KeepInBlocksApi.BlockChainServices;
using Nethereum.Web3.Accounts.Managed;
using Nethereum.Web3;
using KeepInBlocksApi.BlockChainServices.Cryptography;

namespace KeepInBlocksApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CredentialsController : ControllerBase
    {
        private readonly InBlocksContext _context;

        public CredentialsController(InBlocksContext context)
        {
            _context = context;
        }

        // GET: api/Credentials
        [HttpGet]
        public IEnumerable<Credentials> GetCredentials()
        {
            return _context.Credentials;
        }

        // GET: api/Credentials/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCredentials([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var credentials = await _context.Credentials.FindAsync(id);

            if (credentials == null)
            {
                return NotFound();
            }

            return Ok(credentials);
        }

        // PUT: api/Credentials/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCredentials([FromRoute] int id, [FromBody] Credentials credentials)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != credentials.Id)
            {
                return BadRequest();
            }

            _context.Entry(credentials).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CredentialsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Credentials
        [HttpPost]
        public async Task<IActionResult> PostCredentials([FromBody] Credentials credentials)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Credentials.Add(credentials);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCredentials", new { id = credentials.Id }, credentials);
        }

        [HttpPost("OneTimeSignIn")]
        public async Task<IActionResult> OneTimeSignIn([FromBody] Credentials credentials)
        {
            Credentials hashedCredentials = new Credentials();

            hashedCredentials.UniqueKey = CustomHashing.ComputeSha256Hash(credentials.UniqueKey);
            hashedCredentials.PrimaryKey = CustomEncryption.Encrypt(credentials.PrimaryKey,credentials.UniqueKey );

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            GenericResponse<Credentials> response = new GenericResponse<Credentials>();
            try
            {
                _context.Credentials.Add(hashedCredentials);
                await _context.SaveChangesAsync();

                response.HasError = false;
                response.Messege = "successfull";
                response.Model = hashedCredentials;
                response.StatusCode = 200;

            }
            catch (Exception e)
            {
                response.HasError = true;
                response.Messege = e.ToString();
                response.Model = null;
                response.StatusCode = 400;


            }


            return Ok(response);

        }

        private Credentials getPrivateKey(string UniqueKey)
        {
            var password = CustomHashing.ComputeSha256Hash(UniqueKey);
            var model = _context.Credentials.Where(p =>p.UniqueKey==password).FirstOrDefault();
            model.PrimaryKey = CustomEncryption.Decrypt(model.PrimaryKey, UniqueKey);

            return  model;
        }

        [HttpPost("PostDataInBlocks")]
        public async Task<IActionResult> PostDataInBlocks([FromBody]DataModel dataModel,[FromQuery]string uniqueKey)
        {
            GenericResponse<DataModel> response = new GenericResponse<DataModel>();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var userModel = getPrivateKey(uniqueKey);

            var account = new Account(userModel.PrimaryKey);
            var web3 = new Nethereum.Geth.Web3Geth(account, "https://ropsten.infura.io/v3/1e1358ffb3db40f69b7bdb6c51d016b6");

            BlockChainController blockChainController = new BlockChainController(web3, account);

            try
            {
                var reciept = await blockChainController.SetContractData(dataModel, uniqueKey);

                if(reciept.Item2!=null)
                {

                    Transaction model = new Transaction();
                    model.CredentialsId = userModel.Id;
                    model.TransactionHash = reciept.Item2;
                    
                    _context.Transaction.Add(model);
                    await _context.SaveChangesAsync();

                }
                 

                if (reciept.Item1 != null)
                {

                    response.HasError = false;
                    response.Messege = "Sucessfull";
                    response.Model = dataModel;
                    response.StatusCode = 200;
                }
                else
                {

                    response.HasError = true;
                    response.Messege = "unsucessfull";
                    response.Model = null;
                    response.StatusCode = 400;

                }

            }
            catch (Exception e)
            {
                response.Messege = e.ToString();
            }

            return Ok(response);
        }


        [HttpGet("CreateWallet")]
        public async Task<IActionResult> CreateWallet(string uniqueKey)
        {
            GenericResponse<string> response = new GenericResponse<string>();

            BlockChainController chainController = new BlockChainController();
            try
            {
                var account = await chainController
                    .CreateWallet(uniqueKey);

                if(account!=null)
                {
                    response.HasError = false;
                    response.Messege = "Sucessfull";
                    response.Model = account;
                    response.StatusCode = 200;
                }

            }
            catch(Exception e)
            {
                response.HasError = true;
                response.Messege = "unsucessfull";
                response.Model = null;
                response.StatusCode = 400;
            }


            return Ok(response);


        }



        [HttpGet ("GetDataFromBlocks")]
        public async Task<IActionResult> GetDataFromBlocks(string uniqueKey)
        {
            GenericResponse<List<DataModel>> response = new GenericResponse<List<DataModel>>();
            var userModel = getPrivateKey(uniqueKey);

            var account = new Account(userModel.PrimaryKey);
            var web3 = new Web3(account, "https://ropsten.infura.io/v3/1e1358ffb3db40f69b7bdb6c51d016b6");

            BlockChainController blockChainController = new BlockChainController(web3,account);


            var listofData = await blockChainController.GetContractData(uniqueKey); 
            
            if(listofData!=null)
            {
                response.HasError = false;
                response.Messege = "Sucessfull";
                response.Model = listofData;
                response.StatusCode = 200;
            }
            else
            {
                response.HasError = true;
                response.Messege = "UnSucessfull";
                response.Model = null;
                response.StatusCode = 400;


            }

            return Ok(response);
        }

        // DELETE: api/Credentials/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCredentials([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var credentials = await _context.Credentials.FindAsync(id);
            if (credentials == null)
            {
                return NotFound();
            }

            _context.Credentials.Remove(credentials);
            await _context.SaveChangesAsync();

            return Ok(credentials);
        }

        private bool CredentialsExists(int id)
        {
            return _context.Credentials.Any(e => e.Id == id);
        }
    }
}