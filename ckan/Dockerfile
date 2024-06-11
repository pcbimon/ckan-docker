FROM ckan/ckan-base:2.9.9

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples
### Scheming ###
RUN  pip3 install -e 'git+https://github.com/ckan/ckanext-scheming.git@master#egg=ckanext-scheming'
### Hierarchy ###
RUN  pip3 install -e 'git+https://github.com/ckan/ckanext-hierarchy.git#egg=ckanext-hierarchy' && \
     pip3 install -r ${APP_DIR}/src/ckanext-hierarchy/requirements.txt
### PDF View ###
RUN  pip3 install -e 'git+https://github.com/ckan/ckanext-pdfview.git#egg=ckanext-pdfview'
RUN pip3 install -e 'git+https://github.com/ckan/ckanext-xloader.git@master#egg=ckanext-xloader' && \ 
   pip3 install -r ${APP_DIR}/src/ckanext-xloader/requirements.txt && \
   pip3 install -U requests[security]

### OAuth2 ###
RUN pip3 install -e 'git+https://github.com/pcbimon/ckanext-oauth2#egg=ckanext-oauth2'
### Thai GDC ###
# RUN mkdir -p ${APP_DIR}/src/ckanext-thai_gdc
# COPY plugins/thai_gdc/* ${APP_DIR}/src/ckanext-thai_gdc
# RUN pip3 install -r ${APP_DIR}/src/ckanext-thai_gdc/requirements-py3.txt
# RUN python3 ${APP_DIR}/src/ckanext-thai_gdc/setup.py develop
# RUN  pip3 install -e 'git+https://gitlab.nectec.or.th/opend/ckanext-thai_gdc.git@v2.1.0#egg=ckanext-thai_gdc'

# Copy custom initialization scripts
COPY docker-entrypoint.d/* /docker-entrypoint.d/
COPY setup/start_ckan.sh.override ${APP_DIR}/start_ckan.sh
RUN pip3 install -r ${APP_DIR}/src/ckan/requirements.txt

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY patches ${APP_DIR}/patches

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done
