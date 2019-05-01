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
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{<Input eventlog_json>}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sModule\s+im_msvistalog}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sExec\s+delete\(\$Keywords\);}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{\s\sExec\s+\$raw_event\s\=\sto_json\(\);}) }
      it { is_expected.to contain_concat__fragment('input_eventlog_json').with_content(%r{</Input>}) }
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
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{<Input logfile>}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sModule\s+im_file}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sFile\s+'C:/logfile\.log'}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{\s\sInputType\s+'multiline'}) }
        it { is_expected.to contain_concat__fragment('input_logfile').with_content(%r{</Input>}) }
      end
    end
  end
end
