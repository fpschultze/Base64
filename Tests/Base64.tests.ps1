$ModuleRoot = Split-Path -Parent $PSScriptRoot
$ModuleFile = (Split-Path -Leaf $PSCommandPath) -replace '\.tests\.ps1$', '.psm1'
Import-Module "$ModuleRoot\$ModuleFile"

$TestText = 'Get-ChildItem $env:TEMP | ?{$_.LastWriteTime -lt (Get-Date).AddDays(-1)}'
$TestBase64 = 'RwBlAHQALQBDAGgAaQBsAGQASQB0AGUAbQAgACQAZQBuAHYAOgBUAEUATQBQACAAfAAgAD8AewAkAF8ALgBMAGEAcwB0AFcAcgBpAHQAZQBUAGkAbQBlACAALQBsAHQAIAAoAEcAZQB0AC0ARABhAHQAZQApAC4AQQBkAGQARABhAHkAcwAoAC0AMQApAH0A'

Describe 'ConvertTo-Base64String' {
  Context 'Running with arguments' {
    It 'does return Base64 encoded text' {
      ConvertTo-Base64String $TestText | Should Be $TestBase64
    }
  }
}

Describe 'ConvertFrom-Base64String' {
  Context 'Running with valid arguments' {
    It 'does return the original text' {
      ConvertFrom-Base64String $TestBase64 | Should Be $TestText
    }
  }
  Context 'Running with non-base64 arguments' {
    It 'does not return anything and displays warning' {
      ConvertFrom-Base64String $TestText | Should BeNullOrEmpty
    }
  }
}
