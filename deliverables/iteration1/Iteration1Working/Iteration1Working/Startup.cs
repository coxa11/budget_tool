using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Iteration1Working.Startup))]
namespace Iteration1Working
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
