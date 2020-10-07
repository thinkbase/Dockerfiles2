echo "" >> /etc/profile
echo "# Transfer RT_PROMPT variable to u01" >> /etc/profile

echo "export RT_PROMPT='${RT_PROMPT}'" >> /etc/profile
