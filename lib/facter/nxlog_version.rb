Facter.add(:nxlog_version) do
  setcode do
    if Facter.value('kernel') != 'windows'
      service = '/usr/lib/systemd/system/nxlog.service'
      if File.exist?(service)
        nxlog_bin = 'cat ' + service + ' | grep -e \'ExecStart=\' | awk -F\'ExecStart=\' \'{print $2}\' | awk \'{print $1}\''
        nxlog_fullpath = Facter::Util::Resolution.exec(nxlog_bin)
        nxlog_version_command = nxlog_fullpath + ' -h | head -n1'
        nxlog_version = Facter::Util::Resolution.exec(nxlog_version_command)
        %r{(nxlog)-([\w\.]+)}.match(nxlog_version)[2]
      end
    else
      service = 'reg query "HKLM\System\CurrentControlSet\Services\nxlog" /v "ImagePath" | more +2'
      nxlog_fullpath = Facter::Util::Resolution.exec(service).sub(/^ImagePath    REG_EXPAND_SZ    /, '')
      nxlog_version_command = nxlog_fullpath + ' -h | findstr "^nxlog"'
      if system(nxlog_version_command, :out => ['nul', 'a'], :err => ['nul', 'a'])
       IO.popen(nxlog_version_command) { |io| while (line = io.gets) do nxlog_version = line end }
       %r{(nxlog)-([\w\.]+)}.match(nxlog_version)[2]
      end
    end
  end
end
