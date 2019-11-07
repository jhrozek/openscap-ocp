FROM registry.access.redhat.com/ubi8/ubi-minimal

LABEL \
    name="openscap-ocp4" \
    version="testing" \
    io.k8s.display-name="OpenSCAP (OCP4)" \
    io.openshift.tags="security openscap scan"

COPY \
    content/*.xml /var/lib/content/

COPY \
    jhrozek-openscap-with-chroot-epel-8.repo /etc/yum.repos.d/

RUN true \
    && microdnf install -y openscap-scanner \
    && microdnf clean all \
    && true

COPY ./openscap-container-entrypoint.sh /
RUN ["chmod", "+x", "/openscap-container-entrypoint.sh"]
ENTRYPOINT ["/openscap-container-entrypoint.sh"]
