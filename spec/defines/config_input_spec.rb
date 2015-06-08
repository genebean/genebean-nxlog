require 'spec_helper'

describe 'nxlog::config::input', :type => :define do

  context 'On Windows' do
    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows'
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
      it { should contain_concat__fragment('input_eventlog_json').with_content(/^<Input eventlog_json>$/) }
      it { should contain_concat__fragment('input_eventlog_json').with_content(/\s\sModule\s+im_msvistalog$/) }
      it { should contain_concat__fragment('input_eventlog_json').with_content(/\s\sExec\s+delete\(\$Keywords\);$/) }
      it { should contain_concat__fragment('input_eventlog_json').with_content(/\s\sExec\s+\$raw_event\s\=\sto_json\(\);$/) }
      it { should contain_concat__fragment('input_eventlog_json').with_content(/^<\/Input>$/) }
    end

  end

end
