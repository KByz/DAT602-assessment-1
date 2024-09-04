using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using MySql.Data.MySqlClient;


namespace Dust2Dust___DAT602_Kira_Byrne
{
    class LogInDAO
    {
        private static string connectionString
        {
            get { return "Server=localhost;Port=3306;Database=dust2dust;Uid=root;password=Kn1ght51987!;"; }

        }

        private static MySqlConnection _mySqlConnection = null;
        public static MySqlConnection mySqlConnection
        {
            get
            {
                if (_mySqlConnection == null)
                {
                    _mySqlConnection = new MySqlConnection(connectionString);
                }

                return _mySqlConnection;

            }
        }



        public string RegisterPlayer(string pUserName, string pPassword)
        {

            List<MySqlParameter> p = new List<MySqlParameter>();
            var aP = new MySqlParameter("@Username", MySqlDbType.VarChar, 50);
            aP.Value = pUserName;
            p.Add(aP);

            var bP = new MySqlParameter("@password", MySqlDbType.VarChar, 1000);
            bP.Value = pPassword;
            p.Add(bP);

            var aDataSet = MySqlHelper.ExecuteDataset(LogInDAO.mySqlConnection, "CALL registerPlayer(@Username, @Password)", p.ToArray());

            // expecting one table with one row
            return (aDataSet.Tables[0].Rows[0])["MESSAGE"].ToString();
        }

        public Boolean CheckUsernameAndPassword(string pUserName, string pPassword)
        {
            Boolean lcResult = false;
            List<MySqlParameter> p = new List<MySqlParameter>();
            var aP = new MySqlParameter("@Username", MySqlDbType.VarChar, 45);
            aP.Value = pUserName;
            p.Add(aP);

            var bP = new MySqlParameter("@Password", MySqlDbType.VarChar, 45);
            bP.Value = pPassword;
            p.Add(bP);

            var aDataSet = MySqlHelper.ExecuteDataset(LogInDAO.mySqlConnection, "CALL checkUsernameAndPassword(@Username, @Password)", p.ToArray());

            var arow = aDataSet.Tables[0].Rows[0];
            if (lcResult == false)
            {
                lcResult = true;
            }
            else
            {
                // Add lines to display ortgher messages
                lcResult = false;
            }

            return lcResult;
        }

        
        public class PlayerInDB
        {

            //    Private _Username As String
            private string _Username;

            public string Username
            {
                get
                {
                    return _Username;
                }
                set
                {

                    _Username = value;
                }
            }
        }
    }
}

