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

#                  --verbose DEVEL
CMD oscap-chroot / xccdf eval --profile xccdf_org.ssgproject.content_profile_ospp --report /tmp/report.html /var/lib/content/ssg-fedora-ds-1.3.xml
