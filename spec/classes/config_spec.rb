require 'spec_helper'

describe 'nxlog::config' do

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
        conf_dir   => 'C:/nxlog/conf',
        conf_file  => 'nxlog.conf',
        nxlog_root => 'C:/nxlog',
      }"
    end

    it 'should use concat to build the config file' do
      should contain_concat('C:/nxlog/conf/nxlog.conf')
    end

    it { should contain_concat__fragment('conf_header').with(
                    'target'  => 'C:/nxlog/conf/nxlog.conf',
                    'order'   => '01'
                )
    }

    it  { should contain_concat__fragment('conf_header').with_content(/define ROOT C:\/nxlog/) }

    it { should contain_concat__fragment('conf_footer').with(
                    'target'  => 'C:/nxlog/conf/nxlog.conf',
                    'content' => '',
                    'order'   => '99'
                )
    }

  end

end
