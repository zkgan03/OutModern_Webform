using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace OutModern.src.Admin.Utils
{
    public static class ValidationUtils
    {
        // check discount value range (int from 0 to 100)
        public static bool IsValidDiscount(int discount)
        {
            return discount >= 0 && discount <= 100;
        }

        // check 2 input date which is string, where end date must be greater than start date
        public static bool IsValidDateRange(string startDate, string endDate)
        {
            return DateTime.Parse(endDate) > DateTime.Parse(startDate);
        }

        public static bool IsValidPrice(string price)
        {
            Regex priceRegrex = new Regex(@"^[0-9]+(\.[0-9]{0,2})?$");

            return decimal.TryParse(price, out decimal _) && priceRegrex.IsMatch(price);
        }

    }
}