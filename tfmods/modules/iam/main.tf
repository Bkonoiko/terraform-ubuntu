resource "aws_iam_user" "user1" {
  name = "user3"
}

resource "aws_iam_group" "group1" {
  name = var.group_name
}

resource "aws_iam_user_group_membership" "groupadd" {
  user = aws_iam_user.user1.name
  groups = [ aws_iam_group.group1.name ]
}
