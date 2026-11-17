(() => {
    const layout = document.querySelector(".layout");
    const sidebarToggle = document.querySelector("[data-sidebar-toggle]");
    if (layout && sidebarToggle) {
        const storageKey = "ppt-sidebar-minimized";
        const setSidebarMinimized = (minimized) => {
            layout.classList.toggle("sidebar-minimized", minimized);
            sidebarToggle.setAttribute("aria-expanded", String(!minimized));
            sidebarToggle.setAttribute("aria-label", minimized ? "Expand navigation menu" : "Minimize navigation menu");
            sidebarToggle.setAttribute("title", minimized ? "Expand navigation menu" : "Minimize navigation menu");
        };
        try {
            const savedPreference = window.localStorage.getItem(storageKey);
            setSidebarMinimized(savedPreference === "true" || (savedPreference === null && window.localStorage.getItem("ppt-sidebar-hidden") === "true"));
        } catch (error) {
            setSidebarMinimized(false);
            console.warn("The saved sidebar preference could not be read.", error);
        }
        sidebarToggle.addEventListener("click", () => {
            const minimized = !layout.classList.contains("sidebar-minimized");
            setSidebarMinimized(minimized);
            try {
                window.localStorage.setItem(storageKey, String(minimized));
            } catch (error) {
                console.warn("The sidebar preference could not be saved.", error);
            }
        });
    }

    document.querySelectorAll("form[data-confirm]").forEach((form) => {
        form.addEventListener("submit", (event) => {
            if (!window.confirm(form.dataset.confirm)) event.preventDefault();
        });
    });

    const showStageDialog = async (url) => {
        try {
            const response = await fetch(url, {
                credentials: "same-origin",
                headers: { "X-Requested-With": "XMLHttpRequest" },
            });
            if (!response.ok) throw new Error(`The stage form could not be loaded (${response.status}).`);
            const html = await response.text();
            const documentFromResponse = new DOMParser().parseFromString(html, "text/html");
            const dialogTemplate = documentFromResponse.querySelector("#stage-dialog");
            if (!dialogTemplate) throw new Error("The requested stage form was not included in the response.");
            const dialog = document.importNode(dialogTemplate, true);
            dialog.removeAttribute("data-auto-open");
            document.body.append(dialog);
            const close = () => {
                dialog.close();
                dialog.remove();
            };
            dialog.querySelector("[data-close-stage]")?.addEventListener("click", close);
            dialog.addEventListener("click", (event) => {
                if (event.target === dialog) close();
            });
            dialog.addEventListener("close", () => dialog.remove(), { once: true });
            dialog.showModal();
        } catch (error) {
            console.error("Could not open the workflow stage form.", error);
            window.alert(error instanceof Error ? error.message : "The stage form could not be opened.");
        }
    };

    const showTransactionDetailsDialog = async (url) => {
        try {
            const response = await fetch(url, { credentials: "same-origin" });
            if (!response.ok) throw new Error(`Transaction details could not be loaded (${response.status}).`);
            const html = await response.text();
            const documentFromResponse = new DOMParser().parseFromString(html, "text/html");
            const content = documentFromResponse.querySelector("#transaction-detail-content");
            if (!content) throw new Error("Transaction details were not included in the response.");
            const dialog = document.createElement("dialog");
            dialog.className = "transaction-details-dialog";
            dialog.innerHTML = '<div class="transaction-details-heading"><strong>Transaction Details</strong><button class="dialog-close" type="button" aria-label="Close dialog">&times;</button></div><div class="transaction-details-content"></div>';
            dialog.querySelector(".transaction-details-content").append(document.importNode(content, true));
            const close = () => dialog.close();
            dialog.querySelector(".dialog-close").addEventListener("click", close);
            dialog.addEventListener("click", (event) => {
                if (event.target === dialog) close();
                const stageLink = event.target.closest("[data-open-stage-modal]");
                if (stageLink) {
                    event.preventDefault();
                    void showStageDialog(stageLink.href);
                }
            });
            dialog.addEventListener("close", () => dialog.remove(), { once: true });
            document.body.append(dialog);
            dialog.showModal();
        } catch (error) {
            console.error("Could not open transaction details.", error);
            window.alert(error instanceof Error ? error.message : "Transaction details could not be opened.");
        }
    };

    document.querySelectorAll("tr[data-row-link]").forEach((row) => {
        const openTransaction = () => {
            if (row.dataset.stageModalUrl) {
                void showStageDialog(row.dataset.stageModalUrl);
            } else if (row.dataset.detailModalUrl) {
                void showTransactionDetailsDialog(row.dataset.detailModalUrl);
            } else {
                window.location.assign(row.dataset.rowLink);
            }
        };
        row.addEventListener("click", (event) => {
            if (event.target.closest("button, input, select, textarea, form")) return;
            if (event.target.closest("a")) {
                if (row.dataset.stageModalUrl || row.dataset.detailModalUrl) {
                    event.preventDefault();
                    openTransaction();
                }
                return;
            }
            openTransaction();
        });
        row.addEventListener("keydown", (event) => {
            if (event.key === "Enter" || event.key === " ") {
                event.preventDefault();
                openTransaction();
            }
        });
    });

    document.querySelectorAll("[data-toast]").forEach((toast) => {
        const dismiss = () => {
            toast.classList.add("toast-dismissed");
            window.setTimeout(() => toast.remove(), 220);
        };
        toast.querySelector("[data-close-toast]")?.addEventListener("click", dismiss);
        window.setTimeout(dismiss, 4000);
    });

    if (document.querySelector(".viewer-completion") && !window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
        const confetti = document.createElement("div");
        confetti.className = "confetti-animation";
        confetti.setAttribute("aria-hidden", "true");
        for (let index = 0; index < 36; index += 1) {
            confetti.append(document.createElement("span"));
        }
        document.body.append(confetti);
        window.setTimeout(() => confetti.remove(), 4200);
    }

    const transactionDialog = document.querySelector("#transaction-dialog");
    if (transactionDialog) {
        document.querySelector("[data-open-transaction]")?.addEventListener("click", () => transactionDialog.showModal());
        transactionDialog.querySelectorAll("[data-close-transaction]").forEach((button) => {
            button.addEventListener("click", () => transactionDialog.close());
        });
        transactionDialog.addEventListener("click", (event) => {
            if (event.target === transactionDialog) transactionDialog.close();
        });
    }

    const stageDialog = document.querySelector("#stage-dialog");
    if (stageDialog) {
        const clearSelectedStage = () => {
            const url = new URL(window.location.href);
            url.searchParams.delete("stage");
            window.history.replaceState(null, "", url);
        };
        if (stageDialog.hasAttribute("data-auto-open")) stageDialog.showModal();
        stageDialog.querySelector("[data-close-stage]")?.addEventListener("click", () => {
            stageDialog.close();
            clearSelectedStage();
        });
        stageDialog.addEventListener("click", (event) => {
            if (event.target === stageDialog) {
                stageDialog.close();
                clearSelectedStage();
            }
        });
        stageDialog.addEventListener("cancel", clearSelectedStage);
        stageDialog.addEventListener("close", clearSelectedStage);
    }

    const dialog = document.querySelector("#user-dialog");
    if (dialog) {
        const form = dialog.querySelector("form");
        const stageBoxes = [...dialog.querySelectorAll('input[name="stages[]"]')];
        const role = form.elements.role;
        const stageForRole = {
            "Encoder / Records Staff": ["purchase_requests"],
            "BAC Personnel": ["bac"],
            "Procurement Personnel": ["purchase_orders"],
            "Budget Personnel": ["ors"],
            "Inspection Personnel": ["iar"],
            "Accounting Personnel": ["dv", "jev"],
            Cashier: ["cashier"],
            "Viewer / Management": [],
            Administrator: stageBoxes.map((box) => box.value),
        };
        const setStages = (values) => stageBoxes.forEach((box) => { box.checked = values.includes(box.value); });
        document.querySelector("[data-open-user]")?.addEventListener("click", () => {
            form.reset();
            form.elements.id.value = "";
            form.elements.password.required = true;
            setStages(stageForRole[role.value] || []);
            dialog.showModal();
        });
        document.querySelectorAll("[data-edit-user]").forEach((button) => {
            button.addEventListener("click", () => {
                const user = JSON.parse(button.dataset.editUser);
                form.elements.id.value = user.id;
                form.elements.name.value = user.name;
                form.elements.username.value = user.username;
                role.value = user.role;
                form.elements.password.value = "";
                form.elements.password.required = false;
                setStages(JSON.parse(button.dataset.userStages || "[]"));
                dialog.showModal();
            });
        });
        role.addEventListener("change", () => setStages(stageForRole[role.value] || []));
        dialog.querySelector("[data-close-dialog]")?.addEventListener("click", () => dialog.close());
    }

    document.querySelectorAll('input[name="gross_amount"], input[name="tax"]').forEach((input) => {
        input.addEventListener("input", () => {
            const gross = Number(document.querySelector('[name="gross_amount"]')?.value || 0);
            const tax = Number(document.querySelector('[name="tax"]')?.value || 0);
            const net = document.querySelector('[name="net_amount"]');
            if (net && (!net.dataset.userEdited || !net.value)) net.value = Math.max(0, gross - tax).toFixed(2);
        });
    });
    document.querySelector('[name="net_amount"]')?.addEventListener("input", (event) => { event.currentTarget.dataset.userEdited = "1"; });

    document.querySelectorAll("[data-print]").forEach((button) => button.addEventListener("click", () => window.print()));
})();
