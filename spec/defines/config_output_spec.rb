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
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{<Output logserver>}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sModule\s+om_udp}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sHost\s+logserver.example.com}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sPort\s+6371}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{\s\sExec\s+to_syslog_ietf\(\);}) }
        it { is_expected.to contain_concat__fragment('output_logserver').with_content(%r{</Output>}) }
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
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{<Output logfile>}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{\s\sModule\s+om_file}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{\s\sFile\s+'C:/logfile\.log'}) }
        it { is_expected.to contain_concat__fragment('output_logfile').with_content(%r{</Output>}) }
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
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{<Output sslout>}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sModule\s+om_ssl}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sHost\s+logserver.example.com}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sOutputType Binary}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCAFile %CERTDIR%/ca.pem}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCertFile %CERTDIR%/client-cert.pem}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sCertKeyFile %CERTDIR%/client-key.pem}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sKeyPass secret}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{\s\sAllowUntrusted TRUE}) }
        it { is_expected.to contain_concat__fragment('output_sslout').with_content(%r{</Output>}) }
      end
    end
  end
end
