pipeline{
    agent any
    environment {
        DIR="$HOME"
    }
    stages{
        stage('build'){
            steps{
                sh '''
                cd DIR
                echo "if loop completed" 
                if [! -f ACE-6.4.7.tar]
                then
                sudo wget http://download.dre.vanderbilt.edu/previous_versions/ACE-6.4.7.tar.gz
                gunzip ACE-6.4.7.tar.gz
                tar -xvf ACE-6.4.7.tar
                else
                sudo sh -c "echo 'export ACE_ROOT=/opt/ace/ACE_wrappers' >> /etc/profile" 
                sudo sh -c "echo '#include "ace/config-linux.h"'  >> /opt/ace/ACE_wrappers/ace/config.h" 
                sudo sh -c "echo 'INSTALL_PREFIX = /usr/local
                                  include $(ACE_ROOT)/include/makeinclude/platform_linux.GNU' >> /opt/ace/ACE_wrappers/include/makeinclude/platform_macros.GNU"
                sudo cd /opt/ace/ACE_wrappers
                sudo make
                sudo make install
                sudo  sh -c "echo '/opt/ace/ACE_wrappers/lib' >> /etc/ld.so.conf.d/ace.conf"
                sudo ldconfig -v
                fi
                '''
            }
        }
    }
}
