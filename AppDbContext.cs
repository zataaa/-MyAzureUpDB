using Microsoft.EntityFrameworkCore;
using WebApplication1.Models;

namespace WebApplication1.Data
{
    public class AppDbContext : DbContext
    {
        
        
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options) { }

        public DbSet<AdHocReports> AdHocReports { get; set; }
        public DbSet<AuthenticationLogs> AuthenticationLogs { get; set; }
        public DbSet<AutomationLogs> AutomationLogs { get; set; }
        public DbSet<AutomationRules> AutomationRules { get; set; }
        public DbSet<BigMerchant> BigMerchant { get; set; }
        public DbSet<BigMerchantRoles> BigMerchantRoles { get; set; }
        public DbSet<ComplianceLogs> ComplianceLogs { get; set; }
        public DbSet<ComplianceReports> ComplianceReports { get; set; }
        public DbSet<CustomReports> CustomReports { get; set; }
        public DbSet<Dashboard> Dashboard { get; set; }
        public DbSet<DashboardWidget> DashboardWidget { get; set; }
        public DbSet<DepartmentReports> DepartmentReports { get; set; }
        public DbSet<DigitalWallets> DigitalWallets { get; set; }
        public DbSet<Forecasting> Forecasting { get; set; }
        public DbSet<IncidentForecast> IncidentForecast { get; set; }
        public DbSet<IncidentResponse> IncidentResponse { get; set; }
        public DbSet<Incidents> Incidents { get; set; }
        public DbSet<IncidentSolutions> IncidentSolutions { get; set; }
        public DbSet<KPIAlerts> KPIAlerts { get; set; }
        public DbSet<KPIHistory> KPIHistory { get; set; }
        public DbSet<KPIIndicator> KPIIndicator { get; set; }
        public DbSet<KPIIndicators> KPIIndicators { get; set; }
        public DbSet<KPIThresholds> KPIThresholds { get; set; }
        public DbSet<Orders> Orders { get; set; }
        public DbSet<Payments> Payments { get; set; }
        public DbSet<ProductTable> ProductTable { get; set; }
        public DbSet<Products> Products { get; set; }
        public DbSet<ProfitForecast> ProfitForecast{ get; set; }
        public DbSet<RecommendedBigmerchant> RecommendedBigmerchant { get; set; }
        public DbSet<RecommendedSmllmerchant> RecommendedSmllmerchant { get; set; }
        public DbSet<RecommendedUsers> RecommendedUsers { get; set; }
        public DbSet<Reports> Reports { get; set; }
        public DbSet<Roles> Roles { get; set; }
        public DbSet<SalesForecast> SalesForecast { get; set; }
        public DbSet<SalesTrends> SalesTrends { get; set; }
        public DbSet<Schedules> Schedules { get; set; }
        public DbSet<SmallMerchant> SmallMerchant { get; set; }
        public DbSet<SmallMerchantRoles> SmallMerchantRoles { get; set; }
        public DbSet<TeamAssignments> TeamAssignments { get; set; }
        public DbSet<Teams> Teams { get; set; }
        public DbSet<ThreatAlerts> ThreatAlerts { get; set; }
        public DbSet<UserTable> UserTable { get; set; }
        public DbSet<UserForecastTable> UserForecastTable { get; set; }
       // لو عندك كلاس اسمه User
        public DbSet<UserTable> Users { get; set; }

        // لو عندك كلاس اسمه Users (جدول مختلف)
        public DbSet<Users> UsersTable { get; set;}
        public DbSet<UsersForecast> UsersForecast { get; set; }
        public DbSet<UsersRoles> UsersRoles { get; set; }
        public DbSet<WalletTransactions> WalletTransactions { get; set; }
        public DbSet<WorkflowTasks> WorkflowTasks { get; set; }

}
}

        
    
