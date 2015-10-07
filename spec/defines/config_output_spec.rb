require 'spec_helper'

describe 'nxlog::config::output', :type => :define do

  context 'On Windows' do
    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows',
          :concat_basedir  => File.join(Puppet[:vardir],"concat")
      }
    end

    describe 'outputting to a remote host' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => 'C:/nxlog/conf',
          conf_file        => 'nxlog.conf',
          nxlog_root       => 'C:/nxlog',
          output_address   => 'logserver.example.com',
          output_execs     => [ 'to_syslog_ietf()', ],
          output_module    => 'om_udp',
          output_port      => '6371',
        }"
      end

      let(:title) { 'logserver' }

      describe 'builds an Output section for the config file which' do
        it { should contain_concat__fragment('output_logserver').with_content(/<Output logserver>/) }
        it { should contain_concat__fragment('output_logserver').with_content(/\s\sModule\s+om_udp/) }
        it { should contain_concat__fragment('output_logserver').with_content(/\s\sHost\s+logserver.example.com/) }
        it { should contain_concat__fragment('output_logserver').with_content(/\s\sPort\s+6371/) }
        it { should contain_concat__fragment('output_logserver').with_content(/\s\sExec\s+to_syslog_ietf\(\);/) }
        it { should contain_concat__fragment('output_logserver').with_content(/<\/Output>/) }
      end
    end

    describe 'outputting to a local file' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => 'C:/nxlog/conf',
          conf_file        => 'nxlog.conf',
          nxlog_root       => 'C:/nxlog',
          output_file_path => 'C:/logfile.log',
          output_module    => 'om_file',
        }"
      end

      let(:title) { 'logfile' }

      describe 'builds an Output section for the config file which' do
        it { should contain_concat__fragment('output_logfile').with_content(/<Output logfile>/) }
        it { should contain_concat__fragment('output_logfile').with_content(/\s\sModule\s+om_file/) }
        it { should contain_concat__fragment('output_logfile').with_content(/\s\sFile\s+'C:\/logfile\.log'/) }
        it { should contain_concat__fragment('output_logfile').with_content(/<\/Output>/) }
      end
    end

  end

end
