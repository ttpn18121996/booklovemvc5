using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(QLBanSach.Startup))]
namespace QLBanSach
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
