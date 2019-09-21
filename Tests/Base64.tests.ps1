$ModuleRoot = Split-Path -Parent $PSScriptRoot
$ModuleFile = (Split-Path -Leaf $PSCommandPath) -replace '\.tests\.ps1$', '.psm1'
Import-Module "$ModuleRoot\$ModuleFile"

$TestText = 'Get-ChildItem $env:TEMP | ?{$_.LastWriteTime -lt (Get-Date).AddDays(-1)}'
$TestBase64Default = 'R2V0LUNoaWxkSXRlbSAkZW52OlRFTVAgfCA/eyRfLkxhc3RXcml0ZVRpbWUgLWx0IChHZXQtRGF0ZSkuQWRkRGF5cygtMSl9'
$TestBase64ASCII = 'R2V0LUNoaWxkSXRlbSAkZW52OlRFTVAgfCA/eyRfLkxhc3RXcml0ZVRpbWUgLWx0IChHZXQtRGF0ZSkuQWRkRGF5cygtMSl9'
$TestBase64BigEndianUnicode = 'AEcAZQB0AC0AQwBoAGkAbABkAEkAdABlAG0AIAAkAGUAbgB2ADoAVABFAE0AUAAgAHwAIAA/AHsAJABfAC4ATABhAHMAdABXAHIAaQB0AGUAVABpAG0AZQAgAC0AbAB0ACAAKABHAGUAdAAtAEQAYQB0AGUAKQAuAEEAZABkAEQAYQB5AHMAKAAtADEAKQB9'
$TestBase64Unicode = 'RwBlAHQALQBDAGgAaQBsAGQASQB0AGUAbQAgACQAZQBuAHYAOgBUAEUATQBQACAAfAAgAD8AewAkAF8ALgBMAGEAcwB0AFcAcgBpAHQAZQBUAGkAbQBlACAALQBsAHQAIAAoAEcAZQB0AC0ARABhAHQAZQApAC4AQQBkAGQARABhAHkAcwAoAC0AMQApAH0A'
$TestBase64UTF32 = 'RwAAAGUAAAB0AAAALQAAAEMAAABoAAAAaQAAAGwAAABkAAAASQAAAHQAAABlAAAAbQAAACAAAAAkAAAAZQAAAG4AAAB2AAAAOgAAAFQAAABFAAAATQAAAFAAAAAgAAAAfAAAACAAAAA/AAAAewAAACQAAABfAAAALgAAAEwAAABhAAAAcwAAAHQAAABXAAAAcgAAAGkAAAB0AAAAZQAAAFQAAABpAAAAbQAAAGUAAAAgAAAALQAAAGwAAAB0AAAAIAAAACgAAABHAAAAZQAAAHQAAAAtAAAARAAAAGEAAAB0AAAAZQAAACkAAAAuAAAAQQAAAGQAAABkAAAARAAAAGEAAAB5AAAAcwAAACgAAAAtAAAAMQAAACkAAAB9AAAA'
$TestBase64UTF7 = 'R2V0LUNoaWxkSXRlbSArQUNRLWVudjpURU1QICtBSHctID8rQUhzQUpBQmYtLkxhc3RXcml0ZVRpbWUgLWx0IChHZXQtRGF0ZSkuQWRkRGF5cygtMSkrQUgwLQ=='
$TestBase64UTF8 = 'R2V0LUNoaWxkSXRlbSAkZW52OlRFTVAgfCA/eyRfLkxhc3RXcml0ZVRpbWUgLWx0IChHZXQtRGF0ZSkuQWRkRGF5cygtMSl9'

$TestBinFile1 = '{0}\file1.bin' -f $env:TEMP
$TestBinFile2 = '{0}\file2.bin' -f $env:TEMP
$TestBinData = New-Object byte[] 1024
(New-Object System.Random).NextBytes($TestBinData)

Describe 'ConvertTo-Base64String' {
    Context 'Running without Encoding parameter' {
        It 'does return Base64 encoded text (Default encoding)' {
            ConvertTo-Base64String $TestText | Should Be $TestBase64Default
        }
    }
    Context 'Running with Encoding parameter' {
        It 'does return Base64 encoded text (Default encoding)' {
            ConvertTo-Base64String $TestText -Encoding Default | Should Be $TestBase64Default
        }
        It 'does return Base64 encoded text (ASCII encoding)' {
            ConvertTo-Base64String $TestText -Encoding ASCII | Should Be $TestBase64ASCII
        }
        It 'does return Base64 encoded text (BigEndianUnicode encoding)' {
            ConvertTo-Base64String $TestText -Encoding BigEndianUnicode | Should Be $TestBase64BigEndianUnicode
        }
        It 'does return Base64 encoded text (Unicode encoding)' {
            ConvertTo-Base64String $TestText -Encoding Unicode | Should Be $TestBase64Unicode
        }
        It 'does return Base64 encoded text (UTF32 encoding)' {
            ConvertTo-Base64String $TestText -Encoding UTF32 | Should Be $TestBase64UTF32
        }
        It 'does return Base64 encoded text (UTF7 encoding)' {
            ConvertTo-Base64String $TestText -Encoding UTF7 | Should Be $TestBase64UTF7
        }
        It 'does return Base64 encoded text (UTF8 encoding)' {
            ConvertTo-Base64String $TestText -Encoding UTF8 | Should Be $TestBase64UTF8
        }
    }
}

Describe 'ConvertFrom-Base64String' {
    Context 'Running with valid arguments' {
        It 'does return the original text' {
            ConvertFrom-Base64String $TestBase64Default | Should Be $TestText
            ConvertFrom-Base64String $TestBase64Default -Encoding Default | Should Be $TestText
            ConvertFrom-Base64String $TestBase64ASCII -Encoding ASCII | Should Be $TestText
            ConvertFrom-Base64String $TestBase64BigEndianUnicode -Encoding BigEndianUnicode | Should Be $TestText
            ConvertFrom-Base64String $TestBase64Unicode -Encoding Unicode | Should Be $TestText
            ConvertFrom-Base64String $TestBase64UTF32 -Encoding UTF32 | Should Be $TestText
            ConvertFrom-Base64String $TestBase64UTF7 -Encoding UTF7 | Should Be $TestText
            ConvertFrom-Base64String $TestBase64UTF8 -Encoding UTF8 | Should Be $TestText
        }
    }
    Context 'Running with non-base64 arguments' {
        It 'does not return anything and displays warning' {
            ConvertFrom-Base64String $TestText | Should BeNullOrEmpty
        }
    }
}

Describe 'ConvertFrom-BinaryFile and ConvertTo-BinaryFile' {
    Context "Roundtrip binary file, base64, other binary file" {
        [IO.File]::WriteAllBytes($TestBinFile1, $TestBinData)
        Get-ChildItem -Path $TestBinFile1 | ConvertFrom-BinaryFile | ConvertTo-BinaryFile -Destination $TestBinFile2
        It "creates an exact copy of the binary file" {
            Get-FileHash -Path $TestBinFile1, $TestBinFile2 |
                Group-Object -Property Hash |
                Select-Object -ExpandProperty Count -First 1 | Should Be 2
        }
    }
}
