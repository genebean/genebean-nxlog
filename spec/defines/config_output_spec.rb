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

    describe 'sending binary data with module om_ssl' do
      let :pre_condition do
        "class {'nxlog':
          nxlog_root       => 'C:/nxlog',
          conf_dir         => 'C:/nxlog/conf',
          output_address   => 'logserver.example.com',
          output_module    => 'om_ssl',
          output_options   => [
            'OutputType Binary',
            'CAFile %CERTDIR%/ca.pem',
            'CertFile %CERTDIR%/client-cert.pem',
            'CertKeyFile %CERTDIR%/client-key.pem',
            'KeyPass secret',
            'AllowUntrusted TRUE'
          ],
        }"
      end

      let(:title) { 'sslout' }

      describe 'builds an Output section for the config file which' do
        it { should contain_concat__fragment('output_sslout').with_content(/<Output sslout>/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sModule\s+om_ssl/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sHost\s+logserver.example.com/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sOutputType Binary/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sCAFile %CERTDIR%\/ca.pem/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sCertFile %CERTDIR%\/client-cert.pem/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sCertKeyFile %CERTDIR%\/client-key.pem/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sKeyPass secret/) }
        it { should contain_concat__fragment('output_sslout').with_content(/\s\sAllowUntrusted TRUE/) }
        it { should contain_concat__fragment('output_sslout').with_content(/<\/Output>/) }
      end
    end


  end

end
