require 'spec_helper'

describe 'nxlog::config' do
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
        conf_dir   => 'C:/nxlog/conf',
        conf_file  => 'nxlog.conf',
        nxlog_root => 'C:/nxlog',
      }"
    end

    it 'uses concat to build the config file' do
      is_expected.to contain_concat('C:/nxlog/conf/nxlog.conf')
    end

    it {
      is_expected.to contain_concat__fragment('conf_header').with(
        'target'  => 'C:/nxlog/conf/nxlog.conf',
        'order'   => '01',
      )
    }

    it { is_expected.to contain_concat__fragment('conf_header').with_content(%r{define ROOT C:/nxlog}) }

    it {
      is_expected.to contain_concat__fragment('conf_footer').with(
        'target'  => 'C:/nxlog/conf/nxlog.conf',
        'content' => "\n",
        'order'   => '99',
      )
    }
  end
end
