@{
    RootModule        = 'Base64.psm1'
    ModuleVersion     = '1.0.5'
    GUID              = 'f731ffe5-e938-46ad-8b24-e9ab4dd0fc96'
    Author            = 'Frank Peter Schultze'
    CompanyName       = 'fpschultze'
    Copyright         = '(c) 2019 Frank Peter Schultze. Alle Rechte vorbehalten.'
    Description       = 'Functions to convert text to base64 and reverse'
    PowerShellVersion = '2.0'
    # PowerShellHostName = ''
    # PowerShellHostVersion = ''
    # DotNetFrameworkVersion = ''
    # CLRVersion = ''
    # ProcessorArchitecture = ''
    # RequiredModules = @()
    # RequiredAssemblies = @()
    # ScriptsToProcess = @()
    # TypesToProcess = @()
    # FormatsToProcess = @()
    # NestedModules = @()
    FunctionsToExport = 'Convert*-Base64String'
    # CmdletsToExport = '*'
    # VariablesToExport = '*'
    # AliasesToExport = '*'
    # DscResourcesToExport = @()
    # ModuleList = @()
    # FileList = @()
    PrivateData       = @{
        PSData = @{
            Tags         = @('Base64', 'Encoding', 'PSEdition_Desktop', 'Windows')
            LicenseUri   = 'http://www.apache.org/licenses/LICENSE-2.0'
            ProjectUri   = 'https://github.com/fpschultze/Base64'
            # IconUri = ''
            ReleaseNotes = 'Added Encoding parameter'
        }
    }
    # HelpInfoURI = ''
    # DefaultCommandPrefix = ''
}
