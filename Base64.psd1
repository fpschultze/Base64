@{
    RootModule        = 'Base64.psm1'
    ModuleVersion     = '1.0.6'
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
    FunctionsToExport = @('ConvertTo-Base64String', 'ConvertFrom-Base64String', 'ConvertFrom-BinaryFile', 'ConvertTo-BinaryFile')
    # CmdletsToExport = '*'
    # VariablesToExport = '*'
    # AliasesToExport = '*'
    # DscResourcesToExport = @()
    # ModuleList = @()
    # FileList = @()
    PrivateData       = @{
        PSData = @{
            Tags         = @('Base64', 'Encoding')
            # LicenseUri = ''
            ProjectUri   = 'https://github.com/fpschultze/Base64'
            # IconUri = ''
            ReleaseNotes = 'Added functions to deal with binary files'
        }
    }
    # HelpInfoURI = ''
    # DefaultCommandPrefix = ''
}
