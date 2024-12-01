const f = Bun.file("./input");
const lines = (await f.text())
  .split("\n")
  .filter((l) => l !== "")
  .map((l) => l.split(/\s+/).map((n) => parseInt(n)));
let left: number[] = [];
let right: Map<number, number> = new Map();
for (const [l, r] of lines) {
  left.push(l);
  right.set(r, (right.get(r) ?? 0) + 1);
}
let sum = 0;
for (const l of left) {
  sum += l * (right.get(l) ?? 0);
}
console.log(sum);
