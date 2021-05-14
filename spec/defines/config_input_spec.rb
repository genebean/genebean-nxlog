require 'spec_helper'

describe 'nxlog::config::input', type: :define do
  context 'On Windows' do
    let :facts do
      {
        kernel: 'windows',
        osfamily: 'windows',
        operatingsystem: 'windows',
        concat_basedir: File.join(Puppet[:vardir], 'concat'),
      }
    end

    let :pre_condition do
      "class {'nxlog':
        conf_dir     => 'C:/nxlog/conf',
        conf_file    => 'nxlog.conf',
        input_execs  => [
          'delete($Keywords)',
          '$raw_event = to_json()',
        ],
        input_module => 'im_msvistalog',
        nxlog_root   => 'C:/nxlog'
      }"
    end

    let(:title) { 'eventlog_json' }

    describe 'builds an Input section for the config file which' do
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{<Input eventlog_json>\r\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sModule\s+im_msvistalog\r\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sExec\s+delete\(\$Keywords\);\r\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sExec\s+\$raw_event\s\=\sto_json\(\);\r\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{</Input>\r\n}) }
    end

    describe 'inputting from a local file' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir        => 'C:/nxlog/conf',
          conf_file       => 'nxlog.conf',
          nxlog_root      => 'C:/nxlog',
          input_file_path => 'C:/logfile.log',
          input_module    => 'im_file',
          input_type      => 'multiline',
        }"
      end

      let(:title) { 'logfile' }

      describe 'builds an Input section for the config file which' do
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{<Input logfile>\r\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sModule\s+im_file\r\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sFile\s+'C:/logfile\.log'\r\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sInputType\s+multiline\r\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{</Input>\r\n}) }
      end
    end
  end

  context 'On Linux' do
    let :facts do
      {
        kernel: 'Linux',
        osfamily: 'RedHat',
        operatingsystem: 'Redhat',
        concat_basedir: File.join(Puppet[:vardir], 'concat'),
      }
    end

    let :pre_condition do
      "class {'nxlog':
        conf_dir     => '/etc',
        conf_file    => 'nxlog.conf',
        input_execs  => [
          'delete($Keywords)',
          '$raw_event = to_json()',
        ],
        input_module => 'im_msvistalog',
        nxlog_root   => '/etc'
      }"
    end

    let(:title) { 'eventlog_json' }

    describe 'builds an Input section for the config file which' do
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{<Input eventlog_json>\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sModule\s+im_msvistalog\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sExec\s+delete\(\$Keywords\);\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sExec\s+\$raw_event\s\=\sto_json\(\);\n}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{</Input>\n}) }
    end

    describe 'inputting from a local file' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir        => '/etc',
          conf_file       => 'nxlog.conf',
          nxlog_root      => '/etc',
          input_file_path => '/etc/logfile.log',
          input_module    => 'im_file',
          input_type      => 'multiline',
        }"
      end

      let(:title) { 'logfile' }

      describe 'builds an Input section for the config file which' do
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{<Input logfile>\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sModule\s+im_file\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sFile\s+'/etc/logfile\.log'\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sInputType\s+multiline\n}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{</Input>\n}) }
      end
    end
  end
end
