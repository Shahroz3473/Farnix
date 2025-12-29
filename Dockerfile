# Base image لینوکس
FROM ubuntu:22.04

# غیرتعاملی کردن APT و نصب پیش‌نیازها + تنظیم timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    libgdiplus \
    tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Tehran /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

# دایرکتوری کار
WORKDIR /terraria

# کپی تمام فایل‌های سرور
COPY . /terraria

# اجازه اجرا به فایل لینوکس
RUN chmod +x TerrariaServer.bin.x86_64

# باز کردن پورت Terraria
EXPOSE 7777

# اجرای سرور لینوکس
CMD ["./TerrariaServer.bin.x86_64", "-config", "serverconfig.txt"]
