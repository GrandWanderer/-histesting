import { rmSync } from 'node:fs';
import { resolve } from 'node:path';

const docsRoot = resolve(process.cwd(), 'generated-docs');

rmSync(docsRoot, {
    recursive: true,
    force: true
});
