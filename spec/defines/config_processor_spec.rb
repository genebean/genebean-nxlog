require 'spec_helper'

describe 'nxlog::config::processor', :type => :define do
  context 'On Windows' do
    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows',
          :concat_basedir  => File.join(Puppet[:vardir],"concat")
      }
    end

    context 'with pm_transformer' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir                    => 'C:/nxlog/conf',
          conf_file                   => 'nxlog.conf',
          processor_module            => 'pm_transformer',
          processor_input_format      => 'syslog_rfc3164',
          processor_output_format     => 'csv',
          processor_csv_output_fields => [
            '$facility',
            '$severity',
            '$timestamp',
            '$hostname',
            '$application',
            '$pid',
            '$message',
          ],
        }"
      end

      let(:title) { 'transformer'}

      describe 'builds a Processor section for the config file which' do
        it { should contain_concat__fragment('processor_transformer').with_content(/<Processor transformer>/) }
        it { should contain_concat__fragment('processor_transformer').with_content(/\s\sModule\s+pm_transformer/) }
        it { should contain_concat__fragment('processor_transformer').with_content(/\s\sInputFormat\s+syslog_rfc3164/) }
        it { should contain_concat__fragment('processor_transformer').with_content(/\s\sOutputFormat\s+csv/) }
        it { should contain_concat__fragment('processor_transformer').with_content(/\s\sCSVOutputFields\s+\$facility,\s\$severity,\s\$timestamp,\s\$hostname,\s\$application,\s\$pid,\s\$message/) }
        it { should contain_concat__fragment('processor_transformer').with_content(/<\/Processor>/) }
      end

    end

    context 'with an unknown processor module' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => 'C:/nxlog/conf',
          conf_file        => 'nxlog.conf',
          processor_module => 'foo',
        }"
      end

      let(:title) { 'foo'}

      it do
        expect {
          should compile
        }.to raise_error(/A template for foo has not been created yet./)
      end

    end

  end

end
