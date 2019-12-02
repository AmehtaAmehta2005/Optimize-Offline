Function Invoke-Cleanup
{
    [CmdletBinding(DefaultParameterSetName = 'None')]
    Param
    (
        [Parameter(ParameterSetName = 'Install')]
        [Switch]$Install,
        [Parameter(ParameterSetName = 'Boot')]
        [Switch]$Boot,
        [Parameter(ParameterSetName = 'Recovery')]
        [Switch]$Recovery
    )

    $MountPath = Switch ($PSBoundParameters.Keys)
    {
        'Install' { $InstallMount }
        'Boot' { $BootMount }
        'Recovery' { $RecoveryMount }
    }

    @("$MountPath\Windows\WinSxS\Backup\*.*", "$MountPath\Windows\WinSxS\Temp\PendingDeletes\*", "$MountPath\Windows\WinSxS\Temp\TransformerRollbackData\*", "$MountPath\Windows\WinSxS\ManifestCache\*.bin") | Purge -Force
    @("$MountPath\Windows\INF\*.log", "$MountPath\Windows\CbsTemp\*", "$MountPath\PerfLogs", ("$MountPath\" + '$Recycle.Bin')) | Purge
}