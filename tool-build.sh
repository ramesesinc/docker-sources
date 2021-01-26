RUN_DIR=`pwd`
cd $RUN_DIR/core/anubis-webserver/v001
sh build.sh
cd $RUN_DIR/core/enterprise-server/v001
sh build.sh
cd $RUN_DIR/core/gdx-client/v001
sh build.sh
cd $RUN_DIR/web/filipizen-web/v001
sh build.sh
cd $RUN_DIR/cloud-apps/cloud-epayment-server/v001
sh build.sh
cd $RUN_DIR/cloud-apps/cloud-partner-server/v001
sh build.sh
cd $RUN_DIR/cloud-apps/cloud-obo-server/v001
sh build.sh
