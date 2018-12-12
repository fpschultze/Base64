# Add 'ToBase64String' method to System.String
Update-TypeData -TypeName System.String -MemberType ScriptMethod -MemberName ToBase64String -Value {
    param(
        [Parameter()]
        [ValidateSet('ASCII', 'BigEndianUnicode', 'Default', 'Unicode', 'UTF32', 'UTF7', 'UTF8')]
        [string]
        $Encoding = 'Default'
    )
    $ErrorActionPreference = 'Stop'
    try {
        [System.Convert]::ToBase64String([System.Text.Encoding]::$Encoding.GetBytes($this))
    }
    catch {
        $_.Exception.Message | Write-Warning
    }
}

# Add 'FromBase64String' method to System.String
Update-TypeData -TypeName System.String -MemberType ScriptMethod -MemberName FromBase64String -Value {
    param(
        [Parameter()]
        [ValidateSet('ASCII', 'BigEndianUnicode', 'Default', 'Unicode', 'UTF32', 'UTF7', 'UTF8')]
        [string]
        $Encoding = 'Default'
    )
    $ErrorActionPreference = 'Stop'
    try {
        [System.Text.Encoding]::$Encoding.GetString([System.Convert]::FromBase64String($this))
    }
    catch {
        $_.Exception.Message | Write-Warning
    }
}

function ConvertTo-Base64String {
    <#
    .SYNOPSIS
    Converts the given text to a Base64 string.

    .EXAMPLE
    $encodedCommand = ConvertTo-Base64String 'Get-ChildItem $env:TEMP | ?{$_.LastWriteTime -lt (Get-Date).AddDays(-1)}'
    This example creates a Base64 encoded powershell command. This can be used with powershell.exe's -encodedcommand parameter.

    .EXAMPLE
    'Get-ChildItem $env:TEMP | ?{$_.LastWriteTime -lt (Get-Date).AddDays(-1)}' | ConvertTo-Base64String

    .INPUTS
    System.String

    .OUTPUTS
    System.String
  #>

    [OutputType([String])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Text,

        [Parameter()]
        [ValidateSet('ASCII', 'BigEndianUnicode', 'Default', 'Unicode', 'UTF32', 'UTF7', 'UTF8')]
        [string]
        $Encoding = 'Default'
    )
    process {
        $Text.ToBase64String($Encoding)
    }
}

function ConvertFrom-Base64String {
    <#
    .SYNOPSIS
    Converts the given Base64 encoded text to the original text.

    .EXAMPLE
    $Command = ConvertFrom-Base64String $encodedCommand
    This example reverse engineers a previously encoded text.

    .EXAMPLE
    $encodedCommand | ConvertFrom-Base64String

    .INPUTS
    System.String

    .OUTPUTS
    System.String
  #>

    [OutputType([String])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Text,

        [Parameter()]
        [ValidateSet('ASCII', 'BigEndianUnicode', 'Default', 'Unicode', 'UTF32', 'UTF7', 'UTF8')]
        [string]
        $Encoding = 'Default'

    )
    process {
        $Text.FromBase64String($Encoding)
    }
}
