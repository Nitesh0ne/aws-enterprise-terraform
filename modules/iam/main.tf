data "aws_iam_policy_document" "ec2_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {

      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}



resource "aws_iam_role" "ec2" {

  name = local.role_name

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}




resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}




resource "aws_iam_instance_profile" "this" {

  name = local.instance_profile_name

  role = aws_iam_role.ec2.name

}