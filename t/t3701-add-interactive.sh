cat >expected <<EOF
new file mode 100644
index 0000000..d95f3ad
--- /dev/null
+++ b/file
@@ -0,0 +1 @@
+content
EOF
	(echo d; echo 1) | git add -i >output &&
	test_cmp expected diff
	(echo r; echo 1) | git add -i &&
cat >expected <<EOF
index 180b47c..b6f2c08 100644
--- a/file
+++ b/file
@@ -1 +1,2 @@
 baseline
+content
EOF
	(echo d; echo 1) | git add -i >output &&
	test_cmp expected diff
	(echo r; echo 1) | git add -i &&
cat >expected <<EOF
EOF
'

test_expect_success 'setup fake editor' '
	>fake_editor.sh &&
	chmod a+x fake_editor.sh &&
	test_set_editor "$(pwd)/fake_editor.sh"
	(echo e; echo a) | git add -p &&
	test_cmp expected diff
cat >patch <<EOF
@@ -1,1 +1,4 @@
 this
+patch
-does not
 apply
EOF
	echo "#!$SHELL_PATH" >fake_editor.sh &&
	cat >>fake_editor.sh <<\EOF &&
mv -f "$1" oldpatch &&
mv -f patch "$1"
EOF
	chmod a+x fake_editor.sh &&
	(echo e; echo n; echo d) | git add -p >output &&
cat >patch <<EOF
this patch
is garbage
EOF
	(echo e; echo n; echo d) | git add -p >output &&
cat >patch <<EOF
@@ -1,0 +1,0 @@
 baseline
+content
+newcontent
+lines
EOF
cat >expected <<EOF
diff --git a/file b/file
index b5dd6c9..f910ae9 100644
--- a/file
+++ b/file
@@ -1,4 +1,4 @@
 baseline
 content
-newcontent
+more
 lines
EOF
	(echo e; echo n; echo d) | git add -p &&
	test_cmp expected output
	test_cmp expected output &&
cat >patch <<EOF
index 180b47c..b6f2c08 100644
--- a/file
+++ b/file
@@ -1,2 +1,4 @@
+firstline
 baseline
 content
+lastline
EOF
'

# Expected output, similar to the patch but w/ diff at the top
cat >expected <<EOF
diff --git a/file b/file
index b6f2c08..61b9053 100755
--- a/file
+++ b/file
@@ -1,2 +1,4 @@
+firstline
 baseline
 content
+lastline
EOF
test_expect_success 'add first line works' '
	(echo s; echo y; echo y) | git add -p file &&
	git diff --cached > diff &&
	test_cmp expected diff
cat >expected <<EOF
diff --git a/non-empty b/non-empty
deleted file mode 100644
index d95f3ad..0000000
--- a/non-empty
+++ /dev/null
@@ -1 +0,0 @@
-content
EOF
	test_cmp expected diff
cat >expected <<EOF
diff --git a/empty b/empty
deleted file mode 100644
index e69de29..0000000
EOF
	test_cmp expected diff
	for i in 10 20 30 40 50 60
	do
		echo $i
	done >test &&
	for i in 10 15 20 21 22 23 24 30 40 50 60
	do
		echo $i
	done >test
	cat >test <<-\EOF &&
	5
	10
	20
	21
	30
	31
	40
	50
	60
	EOF