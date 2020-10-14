require 'spec_helper'

describe 'nxlog::config::extension', type: :define do
  context 'On Windows using' do
    let :facts do
      {
        kernel: 'windows',
        osfamily: 'windows',
        operatingsystem: 'windows',
        concat_basedir: File.join(Puppet[:vardir], 'concat'),
      }
    end

    context 'using xm_json' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir   => 'C:/nxlog/conf',
          conf_file  => 'nxlog.conf',
          ext_module => 'xm_json',
          nxlog_root => 'C:/nxlog'
        }"
      end

      let(:title) { 'json' }

      describe 'builds an Extension section for the config file which' do
        it { is_expected.to contain_concat__fragment('extension_json').with_content(%r{<Extension json>}) }
        it { is_expected.to contain_concat__fragment('extension_json').with_content(%r{\s\sModule\s+xm_json}) }
        it { is_expected.to contain_concat__fragment('extension_json').with_content(%r{</Extension>}) }
      end
    end

    context 'using xm_csv' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir    => 'C:/nxlog/conf',
          conf_file   => 'nxlog.conf',
          ext_module  => 'xm_csv',
          ext_options => [
            'Fields	$id, $name, $number',
            'FieldTypes integer, string, integer',
            'Delimiter	,',
          ],
          nxlog_root  => 'C:/nxlog'
        }"
      end

      let(:title) { 'csv' }

      describe 'builds an Extension section for the config file which' do
        it { is_expected.to contain_concat__fragment('extension_csv').with_content(%r{<Extension csv>}) }
        it { is_expected.to contain_concat__fragment('extension_csv').with_content(%r{\s\sModule\s+xm_csv}) }
        it { is_expected.to contain_concat__fragment('extension_csv').with_content(%r{\s\sFields\s\$id,\s\$name,\s\$number}) }
        it { is_expected.to contain_concat__fragment('extension_csv').with_content(%r{\s\sFieldTypes\sinteger,\sstring,\sinteger}) }
        it { is_expected.to contain_concat__fragment('extension_csv').with_content(%r{\s\sDelimiter\s,}) }
        it { is_expected.to contain_concat__fragment('extension_csv').with_content(%r{</Extension>}) }
      end
    end
  end
end
