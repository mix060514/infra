FROM postgres:17-alpine

# Layer 1: 安裝環境 (Cached)
RUN apk add --no-cache --virtual .build-deps \
        git \
        build-base \
        clang \
        llvm-dev

# Layer 2: 下載源碼 (Cached)
RUN git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git

# Layer 3: 編譯與安裝
# 終極大絕招：建立假的 clang 和 llvm-lto 來完全繞過版本檢查和 JIT 編譯錯誤
# 我們不在乎 bitcode 是否正確生成，因為我們不需要 JIT
RUN mkdir -p /usr/lib/llvm19/bin \
    && ln -s /usr/bin/clang /usr/bin/clang-19 \
    && echo '#!/bin/sh' > /usr/lib/llvm19/bin/llvm-lto \
    && echo 'exit 0' >> /usr/lib/llvm19/bin/llvm-lto \
    && chmod +x /usr/lib/llvm19/bin/llvm-lto \
    && cd pgvector \
    && make \
    && make install \
    && cd ..

# Layer 4: 清理
RUN rm -rf pgvector && apk del .build-deps