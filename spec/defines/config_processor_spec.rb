require 'spec_helper'

describe 'nxlog::config::processor', type: :define do
  context 'On Windows' do
    let :facts do
      {
        kernel: 'windows',
        osfamily: 'windows',
        operatingsystem: 'windows',
        concat_basedir: File.join(Puppet[:vardir], 'concat'),
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

      let(:title) { 'transformer' }

      # rubocop:disable Metrics/LineLength
      describe 'builds a Processor section for the config file which' do
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{<Processor transformer>\r\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sModule\s+pm_transformer\r\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sInputFormat\s+syslog_rfc3164\r\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sOutputFormat\s+csv\r\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sCSVOutputFields\s+\$facility,\s\$severity,\s\$timestamp,\s\$hostname,\s\$application,\s\$pid,\s\$message\r\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{</Processor>\r\n}) }
      end
      # rubocop:enable Metrics/LineLength
    end

    context 'with an unknown processor module' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => 'C:/nxlog/conf',
          conf_file        => 'nxlog.conf',
          processor_module => 'foo',
        }"
      end

      let(:title) { 'foo' }

      it do
        expect {
          is_expected.to compile
        }.to raise_error(%r{A template for foo has not been created yet.})
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

    context 'with pm_transformer' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir                    => '/etc',
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

      let(:title) { 'transformer' }

      # rubocop:disable Metrics/LineLength
      describe 'builds a Processor section for the config file which' do
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{<Processor transformer>\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sModule\s+pm_transformer\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sInputFormat\s+syslog_rfc3164\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sOutputFormat\s+csv\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{\s\sCSVOutputFields\s+\$facility,\s\$severity,\s\$timestamp,\s\$hostname,\s\$application,\s\$pid,\s\$message\n}) }
        it { is_expected.to contain_concat__fragment('processor_transformer').with_content(%r{</Processor>\n}) }
      end
      # rubocop:enable Metrics/LineLength
    end

    context 'with an unknown processor module' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir         => '/etc',
          conf_file        => 'nxlog.conf',
          processor_module => 'foo',
        }"
      end

      let(:title) { 'foo' }

      it do
        expect {
          is_expected.to compile
        }.to raise_error(%r{A template for foo has not been created yet.})
      end
    end
  end
end
