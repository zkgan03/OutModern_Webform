using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OutModern.src.Admin.Interfaces
{
    public interface IFilter
    {
        void FilterListView(string searchTerm);
    }
}
