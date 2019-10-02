FROM fedora

LABEL \
    name="openscap-ocp4" \
    version="testing" \
    io.k8s.display-name="OpenSCAP (OCP4)" \
    io.openshift.tags="security openscap scan"

COPY \
    content/*.xml /var/lib/content/

RUN true \
    && yum install -y openscap-scanner \
    && yum clean all \
    && true

COPY ./openscap-container-entrypoint.sh /
RUN ["chmod", "+x", "/openscap-container-entrypoint.sh"]
ENTRYPOINT ["/openscap-container-entrypoint.sh"]
