-- =============================================
-- Table: [dbo].[ActiveUsers]
-- =============================================
CREATE TABLE [dbo].[ActiveUsers] (
    [record_id] int NOT NULL,
    [user_id] int NOT NULL,
    [activity_date] date NULL,
    [is_active] bit NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[AdHocReports]
-- =============================================
CREATE TABLE [dbo].[AdHocReports] (
    [report_id] int NOT NULL,
    [report_name] nvarchar(150) NOT NULL,
    [query_text] text NOT NULL,
    [created_by] nvarchar(100) NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[AlertHistory]
-- =============================================
CREATE TABLE [dbo].[AlertHistory] (
    [history_id] int NOT NULL,
    [alert_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [alert_message] nvarchar(500) NULL,
    [severity_level] nvarchar(50) NULL,
    [alert_channel] nvarchar(50) NULL,
    [sent_at] datetime2 NULL,
    [sent_by] nvarchar(100) NULL
);


-- =============================================
-- Table: [dbo].[AlertRules]
-- =============================================
CREATE TABLE [dbo].[AlertRules] (
    [rule_id] int NOT NULL,
    [rule_name] nvarchar(100) NULL,
    [condition_expression] nvarchar(255) NULL,
    [severity_level] nvarchar(50) NULL,
    [alert_channel] nvarchar(50) NULL,
    [created_at] datetime2 NULL,
    [is_active] bit NULL
);


-- =============================================
-- Table: [dbo].[AnalysisDetails]
-- =============================================
CREATE TABLE [dbo].[AnalysisDetails] (
    [detail_id] int NOT NULL,
    [analysis_id] int NOT NULL,
    [factor] nvarchar(150) NULL,
    [factor_description] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[AppAlerts]
-- =============================================
CREATE TABLE [dbo].[AppAlerts] (
    [alert_id] int NOT NULL,
    [app_name] nvarchar(100) NOT NULL,
    [severity] nvarchar(10) NOT NULL,
    [message] nvarchar(255) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ApprovalLogs]
-- =============================================
CREATE TABLE [dbo].[ApprovalLogs] (
    [log_id] int NOT NULL,
    [approval_id] int NOT NULL,
    [action] nvarchar(250) NULL,
    [action_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[AuditLogs]
-- =============================================
CREATE TABLE [dbo].[AuditLogs] (
    [log_id] int NOT NULL,
    [audit_id] int NOT NULL,
    [action] nvarchar(250) NULL,
    [action_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[AuthenticationLogs]
-- =============================================
CREATE TABLE [dbo].[AuthenticationLogs] (
    [ID] int NOT NULL,
    [UserID] int NULL,
    [SmallMerchantID] int NULL,
    [BigMerchantID] int NULL,
    [PasswordHash] nvarchar(200) NOT NULL,
    [LoginTime] datetime NULL,
    [Status] nvarchar(50) NULL
);


-- =============================================
-- Table: [dbo].[AutoExecution]
-- =============================================
CREATE TABLE [dbo].[AutoExecution] (
    [execution_id] int NOT NULL,
    [recommendation_id] int NOT NULL,
    [executed_action] nvarchar(500) NULL,
    [confidence_score] decimal(5,2) NULL,
    [executed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[AutomationLogs]
-- =============================================
CREATE TABLE [dbo].[AutomationLogs] (
    [LogID] int NOT NULL,
    [RuleID] int NULL,
    [TaskID] int NULL,
    [ExecutionTime] datetime NULL,
    [Result] nvarchar(50) NULL,
    [Note] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[AutomationRules]
-- =============================================
CREATE TABLE [dbo].[AutomationRules] (
    [RuleID] int NOT NULL,
    [RuleName] nvarchar(100) NOT NULL,
    [Condition] nvarchar(255) NOT NULL,
    [Action] nvarchar(255) NOT NULL,
    [Status] nvarchar(50) NULL,
    [CreatedAt] datetime NULL,
    [Note] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[AvailabilityLogs]
-- =============================================
CREATE TABLE [dbo].[AvailabilityLogs] (
    [log_id] int NOT NULL,
    [availability_id] int NOT NULL,
    [incident_id] int NULL,
    [log_message] nvarchar(500) NULL,
    [log_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[AvailabilityMonitoring]
-- =============================================
CREATE TABLE [dbo].[AvailabilityMonitoring] (
    [availability_id] int NOT NULL,
    [system_name] nvarchar(150) NOT NULL,
    [uptime_percentage] decimal(5,2) NULL,
    [downtime_minutes] int NULL,
    [status] nvarchar(20) NULL,
    [monitored_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[AvailabilityReports]
-- =============================================
CREATE TABLE [dbo].[AvailabilityReports] (
    [report_id] int NOT NULL,
    [service_name] nvarchar(150) NOT NULL,
    [uptime_percentage] decimal(5,2) NULL,
    [downtime_minutes] int NULL,
    [sla_target] decimal(5,2) NULL,
    [compliance_status] nvarchar(20) NULL,
    [report_date] date NOT NULL,
    [generated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[BandwidthUsage]
-- =============================================
CREATE TABLE [dbo].[BandwidthUsage] (
    [record_id] int NOT NULL,
    [interface] nvarchar(50) NULL,
    [used_bandwidth_mbps] decimal(10,2) NULL,
    [total_bandwidth_mbps] decimal(10,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[BigMerchant]
-- =============================================
CREATE TABLE [dbo].[BigMerchant] (
    [Id] int NOT NULL,
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(200) NOT NULL,
    [PasswordHash] nvarchar(200) NOT NULL,
    [FacebookAccount] nvarchar(200) NULL,
    [InstagramAccount] nvarchar(200) NULL,
    [TwitterAccount] nvarchar(200) NULL,
    [TikTokAccount] nvarchar(200) NULL,
    [LinkedInAccount] nvarchar(200) NULL,
    [Phone1] nvarchar(20) NULL,
    [Phone2] nvarchar(20) NULL,
    [Address] nvarchar(300) NULL,
    [CreatedAt] datetime NULL,
    [UpdatedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[BigMerchantRoles]
-- =============================================
CREATE TABLE [dbo].[BigMerchantRoles] (
    [UserID] int NOT NULL,
    [RoleID] int NOT NULL,
    [BigMerchantID] int NOT NULL
);


-- =============================================
-- Table: [dbo].[BudgetDetails]
-- =============================================
CREATE TABLE [dbo].[BudgetDetails] (
    [detail_id] int NOT NULL,
    [budget_id] int NOT NULL,
    [category] nvarchar(20) NOT NULL,
    [allocated] decimal(15,2) NULL,
    [spent] decimal(15,2) NULL
);


-- =============================================
-- Table: [dbo].[BudgetPlanning]
-- =============================================
CREATE TABLE [dbo].[BudgetPlanning] (
    [budget_id] int NOT NULL,
    [fiscal_year] int NOT NULL,
    [department] nvarchar(150) NOT NULL,
    [allocated_amount] decimal(15,2) NOT NULL,
    [spent_amount] decimal(15,2) NULL,
    [status] nvarchar(20) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[BuildLogs]
-- =============================================
CREATE TABLE [dbo].[BuildLogs] (
    [log_id] int NOT NULL,
    [build_id] int NOT NULL,
    [log_message] nvarchar(500) NULL,
    [log_time] datetime2 NULL
);

-- =============================================
-- Table: [dbo].[CampaignPerformance]
-- =============================================
CREATE TABLE [dbo].[CampaignPerformance] (
    [campaign_id] int NOT NULL,
    [campaign_name] nvarchar(100) NULL,
    [impressions] int NOT NULL,
    [clicks] int NOT NULL,
    [conversions] int NOT NULL,
    [start_date] date NOT NULL,
    [end_date] date NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CapacityImprovement]
-- =============================================
CREATE TABLE [dbo].[CapacityImprovement] (
    [improvement_id] int NOT NULL,
    [resource_type] nvarchar(20) NOT NULL,
    [improvement_action] nvarchar(500) NOT NULL,
    [implemented_by] nvarchar(150) NULL,
    [improvement_status] nvarchar(20) NULL,
    [implemented_at] datetime2 NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CapacityLogs]
-- =============================================
CREATE TABLE [dbo].[CapacityLogs] (
    [log_id] int NOT NULL,
    [monitor_id] int NOT NULL,
    [log_message] nvarchar(500) NULL,
    [log_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CapacityMonitoring]
-- =============================================
CREATE TABLE [dbo].[CapacityMonitoring] (
    [monitor_id] int NOT NULL,
    [system_name] nvarchar(150) NOT NULL,
    [cpu_usage] decimal(5,2) NULL,
    [memory_usage] decimal(5,2) NULL,
    [disk_usage] decimal(5,2) NULL,
    [network_usage] decimal(5,2) NULL,
    [monitored_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CapacityPlanning]
-- =============================================
CREATE TABLE [dbo].[CapacityPlanning] (
    [plan_id] int NOT NULL,
    [resource_type] nvarchar(20) NOT NULL,
    [current_usage] decimal(10,2) NOT NULL,
    [forecast_usage] decimal(10,2) NOT NULL,
    [threshold] decimal(10,2) NOT NULL,
    [recommended_action] nvarchar(250) NULL,
    [forecast_period] nvarchar(10) NOT NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CapacityReportDetails]
-- =============================================
CREATE TABLE [dbo].[CapacityReportDetails] (
    [detail_id] int NOT NULL,
    [report_id] int NOT NULL,
    [system_name] nvarchar(150) NULL,
    [cpu_usage] decimal(5,2) NULL,
    [memory_usage] decimal(5,2) NULL,
    [disk_usage] decimal(5,2) NULL,
    [network_usage] decimal(5,2) NULL
);


-- =============================================
-- Table: [dbo].[CapacityReports]
-- =============================================
CREATE TABLE [dbo].[CapacityReports] (
    [report_id] int NOT NULL,
    [report_type] nvarchar(20) NOT NULL,
    [generated_by] nvarchar(150) NULL,
    [generated_at] datetime2 NULL,
    [summary] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ChangeApproval]
-- =============================================
CREATE TABLE [dbo].[ChangeApproval] (
    [approval_id] int NOT NULL,
    [evaluation_id] int NOT NULL,
    [approved_by] nvarchar(150) NOT NULL,
    [approval_status] nvarchar(20) NOT NULL,
    [approval_notes] nvarchar(500) NULL,
    [approved_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ChangeAttachments]
-- =============================================
CREATE TABLE [dbo].[ChangeAttachments] (
    [attachment_id] int NOT NULL,
    [request_id] int NOT NULL,
    [file_name] nvarchar(250) NULL,
    [file_path] nvarchar(500) NULL,
    [uploaded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ChangeEvaluation]
-- =============================================
CREATE TABLE [dbo].[ChangeEvaluation] (
    [evaluation_id] int NOT NULL,
    [request_id] int NOT NULL,
    [risk_level] nvarchar(20) NOT NULL,
    [estimated_cost] decimal(18,2) NULL,
    [expected_benefit] nvarchar(500) NULL,
    [evaluation_status] nvarchar(20) NULL,
    [evaluated_by] nvarchar(150) NULL,
    [evaluated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ChangeImplementation]
-- =============================================
CREATE TABLE [dbo].[ChangeImplementation] (
    [implementation_id] int NOT NULL,
    [approval_id] int NOT NULL,
    [implemented_by] nvarchar(150) NOT NULL,
    [implementation_status] nvarchar(20) NULL,
    [implementation_notes] nvarchar(500) NULL,
    [implemented_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ChangeRequest]
-- =============================================
CREATE TABLE [dbo].[ChangeRequest] (
    [request_id] int NOT NULL,
    [requester] nvarchar(150) NOT NULL,
    [change_type] nvarchar(20) NOT NULL,
    [description] nvarchar(500) NULL,
    [priority] nvarchar(5) NOT NULL,
    [status] nvarchar(20) NULL,
    [submitted_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ChannelROI]
-- =============================================
CREATE TABLE [dbo].[ChannelROI] (
    [channel_id] int NOT NULL,
    [channel_name] nvarchar(100) NULL,
    [spend_amount] decimal(15,2) NULL,
    [revenue_generated] decimal(15,2) NULL,
    [roi_percentage] decimal(5,2) NULL,
    [report_date] date NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CI_Attributes]
-- =============================================
CREATE TABLE [dbo].[CI_Attributes] (
    [attribute_id] int NOT NULL,
    [ci_id] int NOT NULL,
    [attribute_name] nvarchar(150) NULL,
    [attribute_value] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[CI_Relationships]
-- =============================================
CREATE TABLE [dbo].[CI_Relationships] (
    [relationship_id] int NOT NULL,
    [source_ci_id] int NOT NULL,
    [target_ci_id] int NOT NULL,
    [relationship_type] nvarchar(20) NOT NULL
);


-- =============================================
-- Table: [dbo].[ClosureReview]
-- =============================================
CREATE TABLE [dbo].[ClosureReview] (
    [review_id] int NOT NULL,
    [closure_id] int NOT NULL,
    [customer_feedback] nvarchar(500) NULL,
    [satisfaction_score] int NULL,
    [reviewed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ComplianceLogs]
-- =============================================
CREATE TABLE [dbo].[ComplianceLogs] (
    [ComplianceID] int NOT NULL,
    [PolicyName] nvarchar(100) NULL,
    [Status] nvarchar(50) NULL,
    [CheckedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[ComplianceReports]
-- =============================================
CREATE TABLE [dbo].[ComplianceReports] (
    [report_id] int NOT NULL,
    [compliance_type] nvarchar(100) NOT NULL,
    [report_name] nvarchar(150) NOT NULL,
    [status] nvarchar(20) NOT NULL,
    [generated_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[ConfigurationAudit]
-- =============================================
CREATE TABLE [dbo].[ConfigurationAudit] (
    [audit_id] int NOT NULL,
    [ci_id] int NOT NULL,
    [audit_status] nvarchar(20) NULL,
    [findings] nvarchar(500) NULL,
    [audited_by] nvarchar(150) NULL,
    [audit_date] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ConfigurationItems]
-- =============================================
CREATE TABLE [dbo].[ConfigurationItems] (
    [ci_id] int NOT NULL,
    [ci_name] nvarchar(150) NOT NULL,
    [ci_category] nvarchar(20) NOT NULL,
    [ci_status] nvarchar(20) NULL,
    [version] nvarchar(50) NULL,
    [owner] nvarchar(150) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ConfigurationReports]
-- =============================================
CREATE TABLE [dbo].[ConfigurationReports] (
    [report_id] int NOT NULL,
    [report_type] nvarchar(20) NOT NULL,
    [generated_by] nvarchar(150) NULL,
    [generated_at] datetime2 NULL,
    [report_summary] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ConnectionStats]
-- =============================================
CREATE TABLE [dbo].[ConnectionStats] (
    [record_id] int NOT NULL,
    [active_connections] int NULL,
    [max_connections] int NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ContinuityPlanning]
-- =============================================
CREATE TABLE [dbo].[ContinuityPlanning] (
    [plan_id] int NOT NULL,
    [plan_name] nvarchar(150) NOT NULL,
    [critical_services] nvarchar(500) NOT NULL,
    [strategy] nvarchar(20) NULL,
    [owner] nvarchar(150) NULL,
    [status] nvarchar(20) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ContinuityReportDetails]
-- =============================================
CREATE TABLE [dbo].[ContinuityReportDetails] (
    [detail_id] int NOT NULL,
    [report_id] int NOT NULL,
    [plan_id] int NOT NULL,
    [test_id] int NOT NULL,
    [plan_status] nvarchar(50) NULL,
    [test_status] nvarchar(50) NULL
);


-- =============================================
-- Table: [dbo].[ContinuityReports]
-- =============================================
CREATE TABLE [dbo].[ContinuityReports] (
    [report_id] int NOT NULL,
    [report_type] nvarchar(20) NOT NULL,
    [generated_by] nvarchar(150) NULL,
    [generated_at] datetime2 NULL,
    [summary] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ContinuitySteps]
-- =============================================
CREATE TABLE [dbo].[ContinuitySteps] (
    [step_id] int NOT NULL,
    [plan_id] int NOT NULL,
    [step_description] nvarchar(500) NULL,
    [responsible_team] nvarchar(150) NULL,
    [step_status] nvarchar(20) NULL,
    [step_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ContinuityTesting]
-- =============================================
CREATE TABLE [dbo].[ContinuityTesting] (
    [test_id] int NOT NULL,
    [plan_id] int NOT NULL,
    [test_name] nvarchar(150) NOT NULL,
    [scenario] nvarchar(30) NOT NULL,
    [test_status] nvarchar(20) NULL,
    [tested_by] nvarchar(150) NULL,
    [test_date] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ConversionRates]
-- =============================================
CREATE TABLE [dbo].[ConversionRates] (
    [conversion_id] int NOT NULL,
    [campaign_id] int NOT NULL,
    [total_visits] int NOT NULL,
    [total_conversions] int NOT NULL,
    [conversion_rate] decimal(5,2) NULL,
    [report_date] date NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CostDetails]
-- =============================================
CREATE TABLE [dbo].[CostDetails] (
    [detail_id] int NOT NULL,
    [cost_id] int NOT NULL,
    [description] nvarchar(500) NULL,
    [vendor] nvarchar(150) NULL,
    [payment_status] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[CostTracking]
-- =============================================
CREATE TABLE [dbo].[CostTracking] (
    [cost_id] int NOT NULL,
    [department] nvarchar(150) NOT NULL,
    [cost_category] nvarchar(20) NOT NULL,
    [cost_amount] decimal(15,2) NOT NULL,
    [period] nvarchar(20) NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CPUUsage]
-- =============================================
CREATE TABLE [dbo].[CPUUsage] (
    [record_id] int NOT NULL,
    [usage_percent] decimal(5,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CustomerSegmentation]
-- =============================================
CREATE TABLE [dbo].[CustomerSegmentation] (
    [segment_id] int NOT NULL,
    [segment_name] nvarchar(100) NULL,
    [criteria] nvarchar(255) NULL,
    [total_customers] int NOT NULL,
    [avg_revenue_per_customer] decimal(12,2) NULL,
    [report_date] date NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[CustomReports]
-- =============================================
CREATE TABLE [dbo].[CustomReports] (
    [report_id] int NOT NULL,
    [report_name] nvarchar(150) NOT NULL,
    [report_type] nvarchar(20) NOT NULL,
    [query_text] nvarchar(MAX) NULL,
    [created_by] nvarchar(100) NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[Dashboard]
-- =============================================
CREATE TABLE [dbo].[Dashboard] (
    [dashboard_id] int NOT NULL,
    [name] nvarchar(100) NOT NULL,
    [description] nvarchar(255) NULL,
    [Constants] nvarchar(300) NULL,
    [Note] nvarchar(500) NULL,
    [CreatedAt] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[DashboardWidget]
-- =============================================
CREATE TABLE [dbo].[DashboardWidget] (
    [widget_id] int NOT NULL,
    [dashboard_id] int NOT NULL,
    [widget_type] nvarchar(50) NOT NULL,
    [data_source] nvarchar(100) NOT NULL,
    [config] nvarchar(MAX) NULL
);


-- =============================================
-- Table: [dbo].[DBAlertsNN]
-- =============================================
CREATE TABLE [dbo].[DBAlertsNN] (
    [alert_id] int NOT NULL,
    [severity] nvarchar(10) NOT NULL,
    [message] nvarchar(255) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[DemandForecast]
-- =============================================
CREATE TABLE [dbo].[DemandForecast] (
    [forecast_id] int NOT NULL,
    [period_start] date NOT NULL,
    [period_end] date NOT NULL,
    [predicted_demand] int NOT NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[DepartmentReports]
-- =============================================
CREATE TABLE [dbo].[DepartmentReports] (
    [report_id] int NOT NULL,
    [department_name] nvarchar(100) NOT NULL,
    [report_name] nvarchar(150) NOT NULL,
    [kpi_values] nvarchar(MAX) NULL,
    [created_at] datetime2 NOT NULL
);


-- =============================================
-- Table: [dbo].[DeploymentSteps]
-- =============================================
CREATE TABLE [dbo].[DeploymentSteps] (
    [step_id] int NOT NULL,
    [deployment_id] int NOT NULL,
    [step_description] nvarchar(500) NULL,
    [performed_by] nvarchar(150) NULL,
    [step_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[DigitalWallets]
-- =============================================
CREATE TABLE [dbo].[DigitalWallets] (
    [WalletID] int NOT NULL,
    [UserID] int NOT NULL,
    [WalletType] nvarchar(50) NOT NULL,
    [Balance] decimal(18,2) NOT NULL,
    [Status] nvarchar(50) NOT NULL,
    [Note] nvarchar(500) NULL,
    [CreatedAt] datetime NOT NULL,
    [UpdatedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[DiskUsageNN]
-- =============================================
CREATE TABLE [dbo].[DiskUsageNN] (
    [record_id] int NOT NULL,
    [disk_name] nvarchar(50) NULL,
    [used_space_gb] decimal(10,2) NULL,
    [total_space_gb] decimal(10,2) NULL,
    [recorded_at] datetime2 NULL
);

-- =============================================
-- Table: [dbo].[EngagementMetrics]
-- =============================================
CREATE TABLE [dbo].[EngagementMetrics] (
    [metric_id] int NOT NULL,
    [user_id] int NOT NULL,
    [session_count] int NOT NULL,
    [avg_session_duration_minutes] decimal(5,2) NULL,
    [interactions_count] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ErrorRateAnalysis]
-- =============================================
CREATE TABLE [dbo].[ErrorRateAnalysis] (
    [error_id] int NOT NULL,
    [error_type] nvarchar(100) NOT NULL,
    [total_operations] int NOT NULL,
    [error_count] int NOT NULL,
    [error_rate] numeric(26,12) NULL,
    [severity_level] nvarchar(50) NULL,
    [recorded_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[ErrorRatesNN]
-- =============================================
CREATE TABLE [dbo].[ErrorRatesNN] (
    [record_id] int NOT NULL,
    [app_name] nvarchar(100) NOT NULL,
    [error_count] int NOT NULL,
    [total_requests] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[EscalationLogs]
-- =============================================
CREATE TABLE [dbo].[EscalationLogs] (
    [log_id] int NOT NULL,
    [escalation_id] int NOT NULL,
    [action_taken] nvarchar(250) NULL,
    [action_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[EvaluationDetails]
-- =============================================
CREATE TABLE [dbo].[EvaluationDetails] (
    [detail_id] int NOT NULL,
    [evaluation_id] int NOT NULL,
    [factor] nvarchar(150) NULL,
    [factor_score] int NULL,
    [notes] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ExportReports]
-- =============================================
CREATE TABLE [dbo].[ExportReports] (
    [export_id] int NOT NULL,
    [report_id] int NOT NULL,
    [export_format] nvarchar(10) NOT NULL,
    [exported_by] nvarchar(100) NULL,
    [exported_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[FinancialReportDetails]
-- =============================================
CREATE TABLE [dbo].[FinancialReportDetails] (
    [detail_id] int NOT NULL,
    [report_id] int NOT NULL,
    [revenue] decimal(15,2) NULL,
    [expenses] decimal(15,2) NULL,
    [profit] decimal(15,2) NULL,
    [loss] decimal(15,2) NULL,
    [compliance_status] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[FinancialReports]
-- =============================================
CREATE TABLE [dbo].[FinancialReports] (
    [report_id] int NOT NULL,
    [report_type] nvarchar(20) NOT NULL,
    [generated_by] nvarchar(150) NULL,
    [generated_at] datetime2 NULL,
    [summary] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[Forecasting]
-- =============================================
CREATE TABLE [dbo].[Forecasting] (
    [forecast_id] int NOT NULL,
    [forecast_type] nvarchar(20) NOT NULL,
    [model_used] nvarchar(50) NULL,
    [horizon] nvarchar(20) NULL,
    [predicted_value] decimal(12,2) NULL,
    [confidence_interval] nvarchar(50) NULL,
    [created_at] datetime NOT NULL
);

-- =============================================
-- Table: [dbo].[ImplementationSteps]
-- =============================================
CREATE TABLE [dbo].[ImplementationSteps] (
    [step_id] int NOT NULL,
    [implementation_id] int NOT NULL,
    [step_description] nvarchar(500) NULL,
    [performed_by] nvarchar(150) NULL,
    [step_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ImprovementHistory]
-- =============================================
CREATE TABLE [dbo].[ImprovementHistory] (
    [history_id] int NOT NULL,
    [improvement_id] int NOT NULL,
    [log_message] nvarchar(500) NULL,
    [log_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ImprovementLogs]
-- =============================================
CREATE TABLE [dbo].[ImprovementLogs] (
    [log_id] int NOT NULL,
    [improvement_id] int NOT NULL,
    [log_message] nvarchar(500) NULL,
    [log_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentAlerts]
-- =============================================
CREATE TABLE [dbo].[IncidentAlerts] (
    [alert_id] int NOT NULL,
    [rule_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [alert_message] nvarchar(500) NULL,
    [severity_level] nvarchar(50) NULL,
    [alert_channel] nvarchar(50) NULL,
    [triggered_at] datetime2 NULL,
    [resolved_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentClassification]
-- =============================================
CREATE TABLE [dbo].[IncidentClassification] (
    [classification_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [category] nvarchar(20) NOT NULL,
    [severity] nvarchar(20) NOT NULL,
    [priority] nvarchar(5) NOT NULL,
    [classified_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentDetection]
-- =============================================
CREATE TABLE [dbo].[IncidentDetection] (
    [incident_id] int NOT NULL,
    [incident_title] nvarchar(200) NULL,
    [incident_description] nvarchar(MAX) NULL,
    [detected_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentDetections]
-- =============================================
CREATE TABLE [dbo].[IncidentDetections] (
    [detection_id] int NOT NULL,
    [system_name] nvarchar(150) NOT NULL,
    [incident_type] nvarchar(150) NOT NULL,
    [severity] nvarchar(20) NOT NULL,
    [detected_at] datetime2 NULL,
    [status] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[IncidentEscalation]
-- =============================================
CREATE TABLE [dbo].[IncidentEscalation] (
    [escalation_id] int NOT NULL,
    [priority_id] int NOT NULL,
    [escalation_level] nvarchar(20) NOT NULL,
    [escalated_to] nvarchar(150) NOT NULL,
    [escalation_channel] nvarchar(20) NOT NULL,
    [escalated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentForecast]
-- =============================================
CREATE TABLE [dbo].[IncidentForecast] (
    [forecast_id] int NOT NULL,
    [category] nvarchar(100) NULL,
    [period_start] date NULL,
    [period_end] date NULL,
    [predicted_incidents] int NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[IncidentLogging]
-- =============================================
CREATE TABLE [dbo].[IncidentLogging] (
    [log_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [system_name] nvarchar(150) NOT NULL,
    [incident_type] nvarchar(150) NOT NULL,
    [severity] nvarchar(20) NOT NULL,
    [description] nvarchar(500) NULL,
    [logged_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentMetrics]
-- =============================================
CREATE TABLE [dbo].[IncidentMetrics] (
    [metric_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [total_incidents] int NOT NULL,
    [resolved_incidents] int NOT NULL,
    [escalated_incidents] int NOT NULL,
    [avg_response_time] nvarchar(50) NULL,
    [avg_resolution_time] nvarchar(50) NULL,
    [generated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentPrioritization]
-- =============================================
CREATE TABLE [dbo].[IncidentPrioritization] (
    [priority_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [severity] nvarchar(20) NOT NULL,
    [impact_level] nvarchar(20) NOT NULL,
    [priority] nvarchar(5) NOT NULL,
    [prioritized_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentReports]
-- =============================================
CREATE TABLE [dbo].[IncidentReports] (
    [incident_id] int NOT NULL,
    [incident_type] nvarchar(100) NULL,
    [severity_level] nvarchar(50) NULL,
    [description] nvarchar(255) NULL,
    [reported_at] datetime2 NULL,
    [status] nvarchar(50) NULL
);


-- =============================================
-- Table: [dbo].[IncidentResolution]
-- =============================================
CREATE TABLE [dbo].[IncidentResolution] (
    [resolution_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [resolution_summary] nvarchar(500) NOT NULL,
    [resolved_by] nvarchar(150) NULL,
    [resolution_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[IncidentResponse]
-- =============================================
CREATE TABLE [dbo].[IncidentResponse] (
    [IncidentID] int NOT NULL,
    [AlertID] int NOT NULL,
    [ResponseAction] nvarchar(255) NULL,
    [ResponseTime] datetime NULL
);


-- =============================================
-- Table: [dbo].[Incidents]
-- =============================================
CREATE TABLE [dbo].[Incidents] (
    [incident_id] int NOT NULL,
    [incident_title] nvarchar(200) NULL,
    [incident_description] nvarchar(MAX) NULL,
    [created_at] datetime NULL,
    [severity] nvarchar(50) NULL,
    [category] nvarchar(100) NULL
);


-- =============================================
-- Table: [dbo].[IncidentSolutions]
-- =============================================
CREATE TABLE [dbo].[IncidentSolutions] (
    [solution_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [solution_text] nvarchar(500) NULL,
    [success_rate] decimal(5,2) NULL,
    [avg_resolution_time] int NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[IndexUsage]
-- =============================================
CREATE TABLE [dbo].[IndexUsage] (
    [index_id] int NOT NULL,
    [table_name] nvarchar(100) NULL,
    [index_name] nvarchar(100) NULL,
    [usage_count] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[KPIAlerts]
-- =============================================
CREATE TABLE [dbo].[KPIAlerts] (
    [alert_id] int NOT NULL,
    [kpi_id] int NOT NULL,
    [recorded_value] decimal(18,2) NOT NULL,
    [threshold_value] decimal(18,2) NOT NULL,
    [alert_level] nvarchar(20) NOT NULL,
    [created_at] datetime NULL,
    [user_id] int NOT NULL
);


-- =============================================
-- Table: [dbo].[KPIHistory]
-- =============================================
CREATE TABLE [dbo].[KPIHistory] (
    [history_id] int NOT NULL,
    [kpi_id] int NOT NULL,
    [recorded_value] decimal(18,2) NOT NULL,
    [recorded_at] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[KPIIndicator]
-- =============================================
CREATE TABLE [dbo].[KPIIndicator] (
    [kpi_id] int NOT NULL,
    [kpi_name] nvarchar(100) NOT NULL,
    [target_value] decimal(18,2) NOT NULL,
    [CreatedAT] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[KPIIndicators]
-- =============================================
CREATE TABLE [dbo].[KPIIndicators] (
    [kpi_id] int NOT NULL,
    [kpi_name] nvarchar(100) NOT NULL,
    [target_value] decimal(18,2) NOT NULL,
    [CreatedAT] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[KPIReportsNN]
-- =============================================
CREATE TABLE [dbo].[KPIReportsNN] (
    [report_id] int NOT NULL,
    [report_type] nvarchar(20) NOT NULL,
    [generated_at] datetime NULL,
    [status] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[KPIThresholds]
-- =============================================
CREATE TABLE [dbo].[KPIThresholds] (
    [threshold_id] int NOT NULL,
    [kpi_id] int NOT NULL,
    [min_value] decimal(18,2) NULL,
    [max_value] decimal(18,2) NULL,
    [alert_level] nvarchar(50) NOT NULL,
    [CreatedAT] datetime NOT NULL
);

-- =============================================
-- Table: [dbo].[LatencyReports]
-- =============================================
CREATE TABLE [dbo].[LatencyReports] (
    [record_id] int NOT NULL,
    [source] nvarchar(100) NULL,
    [destination] nvarchar(100) NULL,
    [latency_ms] decimal(10,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[MemoryUsage]
-- =============================================
CREATE TABLE [dbo].[MemoryUsage] (
    [record_id] int NOT NULL,
    [used_memory_mb] int NOT NULL,
    [total_memory_mb] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[NetworkAlerts]
-- =============================================
CREATE TABLE [dbo].[NetworkAlerts] (
    [alert_id] int NOT NULL,
    [severity] nvarchar(10) NOT NULL,
    [message] nvarchar(255) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[Orders]
-- =============================================
CREATE TABLE [dbo].[Orders] (
    [order_id] int NOT NULL,
    [customer_id] int NOT NULL,
    [order_date] datetime NOT NULL,
    [total_amount] decimal(18,2) NOT NULL
);


-- =============================================
-- Table: [dbo].[PacketLoss]
-- =============================================
CREATE TABLE [dbo].[PacketLoss] (
    [record_id] int NOT NULL,
    [source] nvarchar(100) NULL,
    [destination] nvarchar(100) NULL,
    [loss_percent] decimal(5,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[Payments]
-- =============================================
CREATE TABLE [dbo].[Payments] (
    [PaymentID] int NOT NULL,
    [OrderID] int NOT NULL,
    [UserID] int NOT NULL,
    [Amount] decimal(18,2) NOT NULL,
    [Method] nvarchar(50) NOT NULL,
    [Status] nvarchar(50) NOT NULL,
    [TransactionDate] datetime NOT NULL,
    [Note] nvarchar(500) NULL,
    [CreatedAt] datetime NOT NULL,
    [UpdatedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[PerformanceAnalytics]
-- =============================================
CREATE TABLE [dbo].[PerformanceAnalytics] (
    [record_id] int NOT NULL,
    [component] nvarchar(100) NULL,
    [metric] nvarchar(100) NULL,
    [value] decimal(10,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[PredictiveAnalytics]
-- =============================================
CREATE TABLE [dbo].[PredictiveAnalytics] (
    [prediction_id] int NOT NULL,
    [model_name] nvarchar(100) NULL,
    [target_metric] nvarchar(100) NULL,
    [predicted_value] decimal(10,2) NULL,
    [confidence_level] decimal(5,2) NULL,
    [prediction_date] date NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[PreventionLogs]
-- =============================================
CREATE TABLE [dbo].[PreventionLogs] (
    [log_id] int NOT NULL,
    [prevention_id] int NOT NULL,
    [action_taken] nvarchar(500) NULL,
    [action_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ProblemAnalysis]
-- =============================================
CREATE TABLE [dbo].[ProblemAnalysis] (
    [analysis_id] int NOT NULL,
    [problem_id] int NOT NULL,
    [root_cause] nvarchar(500) NULL,
    [impact_assessment] nvarchar(500) NULL,
    [recommended_actions] nvarchar(500) NULL,
    [analyzed_by] nvarchar(150) NULL,
    [analyzed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ProblemDetection]
-- =============================================
CREATE TABLE [dbo].[ProblemDetection] (
    [problem_id] int NOT NULL,
    [related_incident_id] int NULL,
    [system_name] nvarchar(150) NOT NULL,
    [problem_type] nvarchar(20) NOT NULL,
    [description] nvarchar(500) NULL,
    [detected_at] datetime2 NULL,
    [status] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[ProblemLogs]
-- =============================================
CREATE TABLE [dbo].[ProblemLogs] (
    [log_id] int NOT NULL,
    [problem_id] int NOT NULL,
    [action_taken] nvarchar(250) NULL,
    [action_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ProblemPrevention]
-- =============================================
CREATE TABLE [dbo].[ProblemPrevention] (
    [prevention_id] int NOT NULL,
    [resolution_id] int NOT NULL,
    [preventive_action] nvarchar(500) NOT NULL,
    [owner] nvarchar(150) NULL,
    [status] nvarchar(20) NULL,
    [implemented_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ProblemResolution]
-- =============================================
CREATE TABLE [dbo].[ProblemResolution] (
    [resolution_id] int NOT NULL,
    [problem_id] int NOT NULL,
    [resolution_summary] nvarchar(500) NOT NULL,
    [resolved_by] nvarchar(150) NULL,
    [resolution_status] nvarchar(20) NULL,
    [resolution_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ProductPerformance]
-- =============================================
CREATE TABLE [dbo].[ProductPerformance] (
    [product_id] int NOT NULL,
    [product_name] nvarchar(100) NULL,
    [sales_units] int NULL,
    [revenue] decimal(15,2) NULL,
    [growth_rate] decimal(5,2) NULL,
    [report_date] date NOT NULL
);


-- =============================================
-- Table: [dbo].[Products]
-- =============================================
CREATE TABLE [dbo].[Products] (
    [product_id] int NOT NULL,
    [product_name] nvarchar(200) NOT NULL,
    [category] nvarchar(100) NULL,
    [Price] decimal(18,2) NOT NULL
);


-- =============================================
-- Table: [dbo].[ProductSuggestions]
-- =============================================
CREATE TABLE [dbo].[ProductSuggestions] (
    [suggestion_id] int NOT NULL,
    [user_id] int NOT NULL,
    [product_id] int NOT NULL,
    [confidence_score] decimal(5,2) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ProductTable]
-- =============================================
CREATE TABLE [dbo].[ProductTable] (
    [ProductID] int NOT NULL,
    [ProductName] nvarchar(200) NOT NULL,
    [Description] nvarchar(500) NULL,
    [Price] decimal(18,2) NOT NULL,
    [Stock] int NOT NULL,
    [Category] nvarchar(100) NULL,
    [Note] nvarchar(500) NULL,
    [CreatedAt] datetime NOT NULL,
    [UpdatedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[ProfitForecast]
-- =============================================
CREATE TABLE [dbo].[ProfitForecast] (
    [forecast_id] int NOT NULL,
    [period_start] date NULL,
    [period_end] date NULL,
    [predicted_profit] decimal(12,2) NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime NULL
);

-- =============================================
-- Table: [dbo].[QueryPerformance]
-- =============================================
CREATE TABLE [dbo].[QueryPerformance] (
    [query_id] int NOT NULL,
    [query_text] text NULL,
    [avg_execution_ms] decimal(10,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[DRecommendations]
-- =============================================
CREATE TABLE [dbo].[DRecommendations] (  -- D ADDED BY MISTAKE OR MUST MERG
    [recommendation_id] int NOT NULL,
    [user_id] int NOT NULL,
    [incident_id] int NULL,
    [product_id] int NULL,
    [recommendation_type] nvarchar(50) NOT NULL,
    [recommendation_text] nvarchar(500) NULL,
    [confidence_score] decimal(5,2) NULL,
    [type] nvarchar(50) NOT NULL,
    [target_id] int NULL,
    --[created_at] datetime NOT NULL
);

-- =============================================
-- Table: [dbo].[Recommendations]
-- =============================================
CREATE TABLE [dbo].[Recommendations] (
    [type] nvarchar(50) NOT NULL,
    *************___CANT DELETE__*****************
-- =============================================
-- Table: [dbo].[RecommendedBigmerchant]
-- =============================================
CREATE TABLE [dbo].[RecommendedBigmerchant] (
    [UserID] int NOT NULL,
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [CreatedAT] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[RecommendedSmllmerchant]
-- =============================================
CREATE TABLE [dbo].[RecommendedSmllmerchant] (
    [UserID] int NOT NULL,
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [CreatedAT] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[RecommendedUsers]
-- =============================================
CREATE TABLE [dbo].[RecommendedUsers] (
    [UserID] int NOT NULL,
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [CreatedAT] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[RegionalSales]
-- =============================================
CREATE TABLE [dbo].[RegionalSales] (
    [region] nvarchar(100) NOT NULL,
    [report_date] date NOT NULL,
    [sales_units] int NULL,
    [revenue] decimal(15,2) NULL
);


-- =============================================
-- Table: [dbo].[ReleaseBuild]
-- =============================================
CREATE TABLE [dbo].[ReleaseBuild] (
    [build_id] int NOT NULL,
    [release_id] int NOT NULL,
    [build_version] nvarchar(50) NOT NULL,
    [build_date] datetime2 NULL,
    [build_status] nvarchar(20) NULL,
    [notes] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ReleaseComponents]
-- =============================================
CREATE TABLE [dbo].[ReleaseComponents] (
    [component_id] int NOT NULL,
    [release_id] int NOT NULL,
    [change_request_id] int NULL,
    [component_name] nvarchar(150) NULL,
    [component_type] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[ReleaseDeployment]
-- =============================================
CREATE TABLE [dbo].[ReleaseDeployment] (
    [deployment_id] int NOT NULL,
    [build_id] int NOT NULL,
    [environment] nvarchar(20) NOT NULL,
    [deployment_status] nvarchar(20) NULL,
    [deployed_by] nvarchar(150) NULL,
    [deployment_notes] nvarchar(500) NULL,
    [deployed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ReleasePlanning]
-- =============================================
CREATE TABLE [dbo].[ReleasePlanning] (
    [release_id] int NOT NULL,
    [release_name] nvarchar(150) NOT NULL,
    [planned_date] date NOT NULL,
    [release_status] nvarchar(20) NULL,
    [release_manager] nvarchar(150) NULL,
    [notes] nvarchar(500) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ReleaseReview]
-- =============================================
CREATE TABLE [dbo].[ReleaseReview] (
    [review_id] int NOT NULL,
    [release_id] int NOT NULL,
    [review_status] nvarchar(20) NULL,
    [reviewed_by] nvarchar(150) NULL,
    [review_notes] nvarchar(500) NULL,
    [reviewed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ReportDetails]
-- =============================================
CREATE TABLE [dbo].[ReportDetails] (
    [detail_id] int NOT NULL,
    [report_id] int NOT NULL,
    [ci_id] int NOT NULL,
    [ci_status] nvarchar(50) NULL,
    [compliance_status] nvarchar(50) NULL
);


-- =============================================
-- Table: [dbo].[Reports]
-- =============================================
CREATE TABLE [dbo].[Reports] (
    [report_id] int NOT NULL,
    [report_name] nvarchar(150) NOT NULL,
    [report_type] nvarchar(50) NOT NULL,
    [created_by] nvarchar(100) NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[ResolutionActions]
-- =============================================
CREATE TABLE [dbo].[ResolutionActions] (
    [action_id] int NOT NULL,
    [resolution_id] int NOT NULL,
    [action_description] nvarchar(500) NULL,
    [performed_by] nvarchar(150) NULL,
    [action_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ResolutionSteps]
-- =============================================
CREATE TABLE [dbo].[ResolutionSteps] (
    [step_id] int NOT NULL,
    [resolution_id] int NOT NULL,
    [step_description] nvarchar(500) NULL,
    [performed_by] nvarchar(150) NULL,
    [step_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ResolutionTime]
-- =============================================
CREATE TABLE [dbo].[ResolutionTime] (
    [resolution_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [reported_at] datetime2 NOT NULL,
    [resolved_at] datetime2 NULL,
    [resolution_minutes] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ResourceForecast]
-- =============================================
CREATE TABLE [dbo].[ResourceForecast] (
    [forecast_id] int NOT NULL,
    [resource_type] nvarchar(100) NULL,
    [period_start] date NOT NULL,
    [period_end] date NOT NULL,
    [predicted_usage] int NOT NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ResourceUsageHistory]
-- =============================================
CREATE TABLE [dbo].[ResourceUsageHistory] (
    [usage_id] int NOT NULL,
    [resource_type] nvarchar(20) NOT NULL,
    [usage_percent] decimal(5,2) NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ResourceUtilization]
-- =============================================
CREATE TABLE [dbo].[ResourceUtilization] (
    [resource_id] int NOT NULL,
    [resource_type] nvarchar(50) NOT NULL,
    [utilization_percent] decimal(5,2) NOT NULL,
    [recorded_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[ResponseTime]
-- =============================================
CREATE TABLE [dbo].[ResponseTime] (
    [record_id] int NOT NULL,
    [app_name] nvarchar(100) NULL,
    [avg_response_ms] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[RetentionRates]
-- =============================================
CREATE TABLE [dbo].[RetentionRates] (
    [retention_id] int NOT NULL,
    [cohort_start] date NOT NULL,
    [cohort_end] date NOT NULL,
    [retention_percentage] decimal(5,2) NOT NULL,
    [calculated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[RevenueReports]
-- =============================================
CREATE TABLE [dbo].[RevenueReports] (
    [report_id] int NOT NULL,
    [report_date] date NOT NULL,
    [total_revenue] decimal(15,2) NOT NULL,
    [currency] nvarchar(10) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ReviewDetails]
-- =============================================
CREATE TABLE [dbo].[ReviewDetails] (
    [detail_id] int NOT NULL,
    [review_id] int NOT NULL,
    [criterion] nvarchar(150) NULL,
    [criterion_score] int NULL,
    [comments] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[RiskModeling]
-- =============================================
CREATE TABLE [dbo].[RiskModeling] (
    [model_id] int NOT NULL,
    [risk_type] nvarchar(20) NOT NULL,
    [probability] decimal(5,2) NOT NULL,
    [impact_score] decimal(5,2) NOT NULL,
    [risk_index] decimal(11,4) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[RiskModelResults]
-- =============================================
CREATE TABLE [dbo].[RiskModelResults] (
    [result_id] int NOT NULL,
    [model_id] int NOT NULL,
    [scenario_name] nvarchar(150) NULL,
    [predicted_loss] decimal(18,2) NULL,
    [mitigation_plan] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ROIAnalysis]
-- =============================================
CREATE TABLE [dbo].[ROIAnalysis] (
    [roi_id] int NOT NULL,
    [project_name] nvarchar(150) NOT NULL,
    [investment_amount] decimal(15,2) NOT NULL,
    [revenue_generated] decimal(15,2) NOT NULL,
    [roi_percentage] decimal(38,18) NULL,
    [analysis_period] nvarchar(20) NOT NULL,
    [analyzed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[ROIDetails]
-- =============================================
CREATE TABLE [dbo].[ROIDetails] (
    [detail_id] int NOT NULL,
    [roi_id] int NOT NULL,
    [channel_name] nvarchar(150) NULL,
    [channel_investment] decimal(15,2) NULL,
    [channel_revenue] decimal(15,2) NULL,
    [channel_roi] decimal(38,18) NULL
);


-- =============================================
-- Table: [dbo].[Roles]
-- =============================================
CREATE TABLE [dbo].[Roles] (
    [RoleID] int NOT NULL,
    [RoleName] nvarchar(100) NOT NULL,
    [Permissions] nvarchar(MAX) NULL,
    [Note] nvarchar(500) NULL,
    [CreatedAt] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[RootCauseAnalysis]
-- =============================================
CREATE TABLE [dbo].[RootCauseAnalysis] (
    [rca_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [root_cause] nvarchar(255) NULL,
    [corrective_action] nvarchar(255) NULL,
    [preventive_action] nvarchar(255) NULL,
    [analyzed_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[SalesForecast]
-- =============================================
CREATE TABLE [dbo].[SalesForecast] (
    [forecast_id] int NOT NULL,
    [period_start] date NULL,
    [period_end] date NULL,
    [predicted_sales] decimal(12,2) NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime NOT NULL,
    [horizon] nvarchar(20) NULL
);


-- =============================================
-- Table: [dbo].[SalesForecastNN]
-- =============================================
CREATE TABLE [dbo].[SalesForecastNN] (
    [forecast_id] int NOT NULL,
    [forecast_date] date NOT NULL,
    [expected_sales] decimal(12,2) NOT NULL,
    [confidence_level] decimal(5,2) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[SalesTrends]
-- =============================================
CREATE TABLE [dbo].[SalesTrends] (
    [trend_id] int NOT NULL,
    [product_id] int NOT NULL,
    [trend_type] nvarchar(50) NOT NULL,
    [percentage_change] decimal(5,2) NOT NULL,
    [period_start] date NOT NULL,
    [period_end] date NOT NULL
);


-- =============================================
-- Table: [dbo].[ScenarioResults]
-- =============================================
CREATE TABLE [dbo].[ScenarioResults] (
    [result_id] int NOT NULL,
    [scenario_id] int NOT NULL,
    [outcome_metric] nvarchar(150) NULL,
    [outcome_value] decimal(18,2) NULL
);


-- =============================================
-- Table: [dbo].[ScenarioSimulation]
-- =============================================
CREATE TABLE [dbo].[ScenarioSimulation] (
    [scenario_id] int NOT NULL,
    [scenario_name] nvarchar(150) NOT NULL,
    [description] nvarchar(500) NULL,
    [variable_name] nvarchar(150) NOT NULL,
    [variable_value] decimal(18,2) NOT NULL,
    [predicted_outcome] nvarchar(250) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[Schedules]
-- =============================================
CREATE TABLE [dbo].[Schedules] (
    [ScheduleID] int NOT NULL,
    [TaskID] int NOT NULL,
    [CronExpression] nvarchar(100) NOT NULL,
    [NextRun] datetime NULL,
    [Status] nvarchar(50) NULL,
    [Note] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[SmallMerchant]
-- =============================================
CREATE TABLE [dbo].[SmallMerchant] (
    [Id] int NOT NULL,
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(200) NOT NULL,
    [PasswordHash] nvarchar(200) NOT NULL,
    [FacebookAccount] nvarchar(200) NULL,
    [InstagramAccount] nvarchar(200) NULL,
    [TwitterAccount] nvarchar(200) NULL,
    [TikTokAccount] nvarchar(200) NULL,
    [LinkedInAccount] nvarchar(200) NULL,
    [Phone1] nvarchar(20) NULL,
    [Phone2] nvarchar(20) NULL,
    [Address] nvarchar(300) NULL,
    [CreatedAt] datetime NULL,
    [UpdatedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[SmallMerchantRoles]
-- =============================================
CREATE TABLE [dbo].[SmallMerchantRoles] (
    [UserID] int NOT NULL,
    [RoleID] int NOT NULL,
    [SmallMerchantID] int NOT NULL
);


-- =============================================
-- Table: [dbo].[SystemAlerts]
-- =============================================
CREATE TABLE [dbo].[SystemAlerts] (
    [alert_id] int NOT NULL,
    [alert_type] nvarchar(100) NULL,
    [severity] nvarchar(10) NOT NULL,
    [message] nvarchar(255) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[SystemOrders]
-- =============================================
CREATE TABLE [dbo].[SystemOrders] (
    [system_order_id] int NOT NULL,
    [order_name] nvarchar(100) NOT NULL
);


-- =============================================
-- Table: [dbo].[TeamAssignments]
-- =============================================
CREATE TABLE [dbo].[TeamAssignments] (
    [assignment_id] int NOT NULL,
    [incident_id] int NOT NULL,
    [team_id] int NOT NULL,
    [confidence_score] decimal(5,2) NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[Teams]
-- =============================================
CREATE TABLE [dbo].[Teams] (
    [team_id] int NOT NULL,
    [team_name] nvarchar(100) NULL,
    [specialization] nvarchar(100) NULL,
    [current_load] int NULL,
    [team_lead] nvarchar(100) NULL
);


-- =============================================
-- Table: [dbo].[TestResults]
-- =============================================
CREATE TABLE [dbo].[TestResults] (
    [result_id] int NOT NULL,
    [test_id] int NOT NULL,
    [outcome] nvarchar(500) NULL,
    [recovery_time_minutes] int NULL,
    [lessons_learned] nvarchar(500) NULL
);


-- =============================================
-- Table: [dbo].[ThreatAlerts]
-- =============================================
CREATE TABLE [dbo].[ThreatAlerts] (
    [AlertID] int NOT NULL,
    [AlertType] nvarchar(100) NULL,
    [Description] nvarchar(255) NULL,
    [DetectedAt] datetime NULL,
    [Status] nvarchar(50) NULL
);


-- =============================================
-- Table: [dbo].[Throughput]
-- =============================================
CREATE TABLE [dbo].[Throughput] (
    [record_id] int NOT NULL,
    [app_name] nvarchar(100) NULL,
    [requests_per_second] decimal(10,2) NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[TicketAssignment]
-- =============================================
CREATE TABLE [dbo].[TicketAssignment] (
    [assignment_id] int NOT NULL,
    [ticket_id] int NOT NULL,
    [assigned_to] nvarchar(150) NOT NULL,
    [team_name] nvarchar(150) NULL,
    [assignment_status] nvarchar(20) NULL,
    [assigned_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[TicketClosure]
-- =============================================
CREATE TABLE [dbo].[TicketClosure] (
    [closure_id] int NOT NULL,
    [ticket_id] int NOT NULL,
    [closed_by] nvarchar(150) NOT NULL,
    [closure_notes] nvarchar(500) NULL,
    [closure_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[TicketCreation]
-- =============================================
CREATE TABLE [dbo].[TicketCreation] (
    [ticket_id] int NOT NULL,
    [requester] nvarchar(150) NOT NULL,
    [system_name] nvarchar(150) NOT NULL,
    [issue_type] nvarchar(20) NOT NULL,
    [description] nvarchar(500) NULL,
    [severity] nvarchar(20) NOT NULL,
    [status] nvarchar(20) NULL,
    [created_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[TicketTracking]
-- =============================================
CREATE TABLE [dbo].[TicketTracking] (
    [tracking_id] int NOT NULL,
    [assignment_id] int NOT NULL,
    [current_status] nvarchar(20) NOT NULL,
    [updated_by] nvarchar(150) NULL,
    [updated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[TrackingLogs]
-- =============================================
CREATE TABLE [dbo].[TrackingLogs] (
    [log_id] int NOT NULL,
    [tracking_id] int NOT NULL,
    [status_change] nvarchar(150) NULL,
    [change_time] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[TrendForecasting]
-- =============================================
CREATE TABLE [dbo].[TrendForecasting] (
    [forecast_id] int NOT NULL,
    [metric_name] nvarchar(150) NOT NULL,
    [forecast_period] nvarchar(20) NOT NULL,
    [forecast_value] decimal(18,2) NOT NULL,
    [confidence_level] decimal(5,2) NULL,
    [generated_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[UserForecastTable]
-- =============================================
CREATE TABLE [dbo].[UserForecastTable] (
    [forecast_id] int NOT NULL,
    [period_start] date NULL,
    [period_end] date NULL,
    [predicted_users] int NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime NOT NULL
);


-- =============================================
-- Table: [dbo].[UserGrowth]
-- =============================================
CREATE TABLE [dbo].[UserGrowth] (
    [growth_id] int NOT NULL,
    [report_date] date NOT NULL,
    [new_users] int NOT NULL,
    [total_users] int NOT NULL,
    [recorded_at] datetime2 NULL
);


-- =============================================
-- Table: [dbo].[UsersData]
-- =============================================
CREATE TABLE [dbo].[UsersData] (
    [UserID] int NOT NULL, -- PK
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(200) NOT NULL,
    [PasswordHash] nvarchar(200) NOT NULL,
    [FacebookAccount] nvarchar(200) NULL,
    [InstagramAccount] nvarchar(200) NULL,
    [TwitterAccount] nvarchar(200) NULL,
    [TikTokAccount] nvarchar(200) NULL,
    [LinkedInAccount] nvarchar(200) NULL,
    [Phone1] nvarchar(20) NULL,
    [Phone2] nvarchar(20) NULL,
    [Address] nvarchar(300) NULL,
    [CreatedAt] datetime NULL,
    [UpdatedAt] datetime NULL,
    [RoleID] int NULL
    
);


-- =============================================
-- Table: [dbo].[UsersForecast]
-- =============================================
CREATE TABLE [dbo].[UsersForecast] (
    [forecast_id] int NOT NULL,
    [period_start] date NULL,
    [period_end] date NULL,
    [predicted_users] int NULL,
    [confidence_interval] nvarchar(50) NULL,
    [model_used] nvarchar(50) NULL,
    [created_at] datetime NULL
);


-- =============================================
-- Table: [dbo].[UsersRoles]
-- =============================================
CREATE TABLE [dbo].[UsersRoles] (
    [UserID] int NOT NULL,
    [RoleID] int NOT NULL,
    [UsersID] int NOT NULL
);


-- =============================================
-- Table: [dbo].[Users] /*تم التغيير الي*/
-- =============================================
CREATE TABLE [dbo].[Users] (
    [UserID] int NOT NULL, -- PK
    [UserName] nvarchar(100) NOT NULL,
    [Email] nvarchar(200) NOT NULL,
    [CreatedAT] datetime NOT NULL,
    PasswordHash NVARCHAR(200) NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Active',
    Notes NVARCHAR(MAX) NULL;
   
);


-- =============================================
-- Table: [dbo].[WalletTransactions]
-- =============================================
CREATE TABLE [dbo].[WalletTransactions] (
    [TransactionID] int NOT NULL,
    [WalletID] int NOT NULL,
    [Amount] decimal(18,2) NOT NULL,
    [TransactionType] nvarchar(50) NOT NULL,
    [CreatedAt] datetime NULL
);


-- =============================================
-- Table: [dbo].[WorkflowTasks]
-- =============================================
CREATE TABLE [dbo].[WorkflowTasks] (
    [TaskID] int NOT NULL,
    [WorkflowName] nvarchar(100) NOT NULL,
    [TaskName] nvarchar(100) NOT NULL,
    [SequenceOrder] int NOT NULL,
    [Status] nvarchar(50) NULL,
    [CreatedAt] datetime NULL,
    [Note] nvarchar(500) NULL
);



Completion time: 2026-08-21T19:59:17.7683983+03:00



