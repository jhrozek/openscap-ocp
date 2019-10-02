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
ENTRYPOINT ["ocap-chroot", "/host", "xccdf", "eval", "--fetch-remote-resources"]
CMD ["--profile", "xccdf_org.ssgproject.content_profile_ospp", "--rule", "xccdf_org.ssgproject.content_rule_no_empty_passwords", "--report", "/tmp/report.html", "/var/lib/content/ssg-rhel8-ds.xml"]
