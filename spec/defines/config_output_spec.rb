require 'spec_helper'

describe 'nxlog::config::output', type: :define do
  context 'On Windows' do
    let :facts do
      {
        kernel: 'windows',
        osfamily: 'windows',
        operatingsystem: 'windows',
        concat_basedir: File.join(Puppet[:vardir], 'concat'),
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
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{<Output logserver>\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sModule\s+om_udp\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sHost\s+logserver.example.com\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sPort\s+6371\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sExec\s+to_syslog_ietf\(\);\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{</Output>\r\n}) }
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
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{<Output logfile>\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{\s\sModule\s+om_file\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{\s\sFile\s+'C:/logfile\.log'\r\n}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{</Output>\r\n}) }
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
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{<Output sslout>\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sModule\s+om_ssl\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sHost\s+logserver.example.com\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sOutputType Binary\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCAFile %CERTDIR%/ca.pem\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCertFile %CERTDIR%/client-cert.pem\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCertKeyFile %CERTDIR%/client-key.pem\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sKeyPass secret\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sAllowUntrusted TRUE\r\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{</Output>\r\n}) }
      end
    end
  end

  context 'On Linux' do
    let :facts do
      {
        kernel: 'Linux',
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        concat_basedir: File.join(Puppet[:vardir], 'concat'),
      }
    end

    describe 'outputting to a remote host' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => '/etc',
          conf_file        => 'nxlog.conf',
          nxlog_root       => '/etc',
          output_address   => 'logserver.example.com',
          output_execs     => [ 'to_syslog_ietf()', ],
          output_module    => 'om_udp',
          output_port      => '6371',
        }"
      end

      let(:title) { 'logserver' }

      describe 'builds an Output section for the config file which' do
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{<Output logserver>\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sModule\s+om_udp\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sHost\s+logserver.example.com\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sPort\s+6371\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sExec\s+to_syslog_ietf\(\);\n}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{</Output>\n}) }
      end
    end

    describe 'outputting to a local file' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => '/etc',
          conf_file        => 'nxlog.conf',
          nxlog_root       => '/etc',
          output_file_path => '/etc/logfile.log',
          output_module    => 'om_file',
        }"
      end

      let(:title) { 'logfile' }

      describe 'builds an Output section for the config file which' do
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{<Output logfile>\n}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{\s\sModule\s+om_file\n}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{\s\sFile\s+'/etc/logfile\.log'\n}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{</Output>\n}) }
      end
    end

    describe 'sending binary data with module om_ssl' do
      let :pre_condition do
        "class {'nxlog':
          nxlog_root       => '/etc',
          conf_dir         => '/etc',
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
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{<Output sslout>\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sModule\s+om_ssl\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sHost\s+logserver.example.com\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sOutputType Binary\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCAFile %CERTDIR%/ca.pem\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCertFile %CERTDIR%/client-cert.pem\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCertKeyFile %CERTDIR%/client-key.pem\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sKeyPass secret\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sAllowUntrusted TRUE\n}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{</Output>\n}) }
      end
    end
  end
end
