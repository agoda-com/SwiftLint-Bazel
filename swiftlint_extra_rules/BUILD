filegroup(
    name = "extra_rules",
    srcs = glob(
        ["**/*.swift"]
        ) + ["ExtraRules.swift"],
    visibility = ["//visibility:public"],
)

genrule(
    name = "extra_rules_func",
    srcs = glob(
        ["rules/*.swift"]
        ),
    outs = ["ExtraRules.swift"],
    cmd = """
set -euo pipefail

echo "public func extraRules() -> [Rule.Type] {" >> $(OUTS)
echo "  [" >> $(OUTS)
for file in $(SRCS); do
  filename=$$(basename -- "$$file")
  echo "    $${filename%.*}.self," >> $(OUTS)
done
echo "  ]" >> $(OUTS)
echo "}" >> $(OUTS)
    """,
)