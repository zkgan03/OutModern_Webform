using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net;
using System.Net.Mail;

//For Hashing
using System.Security.Cryptography;
using System.Text;

namespace StringUtil
{
    public static class PasswordUtil
    {
        // Hashes the password using SHA256 algorithm
        public static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        // Verifies if the plain password matches the hashed password
        public static bool VerifyPassword(string plainPassword, string hashedPassword)
        {
            string hashedPlainPassword = HashPassword(plainPassword);
            return hashedPlainPassword == hashedPassword;
        }
    }

}