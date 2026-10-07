FROM marketsquare/robotframework-browser:20.6.0

USER pwuser
WORKDIR /home/pwuser/app

COPY --chown=pwuser:pwuser requirements.txt /home/pwuser/requirements.txt
RUN pip install --no-cache-dir -r /home/pwuser/requirements.txt

COPY --chown=pwuser:pwuser . .

ENV PYTHONPATH="/home/pwuser/app"
ENV ENV="qa"
ENV HEADLESS="true"

CMD ["bash", "scripts/run_tests.sh", "all", "qa"]
