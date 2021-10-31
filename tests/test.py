def test_passwd_file(host):
    passwd = host.file("/etc/passwd")
    assert passwd.contains("root")